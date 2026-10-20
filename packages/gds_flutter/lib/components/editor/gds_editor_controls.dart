import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 링크에 표시할 이름과 이동할 주소를 지정하는 레코드.
typedef GdsLink = ({
  String name,
  String url,
});

/// 에디터 툴바에서 선택된 툴의 상태를 나타내는 열거형.
enum GdsEditorStatus {
  none,
  plus,
  fontStyle,
  fontColor,
  fontBgColor,
}

/// 에디터 툴바와 옵션 패널을 구성하는 위젯.
class GdsEditorControls extends StatelessWidget {
  const new({
    super.key,
    required this.status,
    required this.toolbar,
    required this.panel,
  });

  final GdsEditorStatus status;
  final GdsEditorToolbar toolbar;
  final GdsEditorPanel panel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        // 상단에 툴바 표시
        toolbar,

        // 상태에 따른 하단 패널 표시
        GdsContainer(
          color: .surfaceGraySubtlest,
          child: GdsFoldable.builder(
            alignment: .bottomCenter,
            visible: status != .none,
            axis: .vertical,
            builder: (_) {
              return GdsTransition.sharedAxis(
                transitionType: .vertical,
                value: status,
                child: panel,
              );
            },
          ),
        ),
      ],
    );
  }

  /// 컨트롤러의 선택 서식과 편집 기능을 툴바 및 패널에 자동으로 연결합니다.
  static Widget fromController(
    QuillController controller, {
    Key? key,
    required Future<String?> Function() onAddImage,
    required Future<GdsLink?> Function() onAddLink,
  }) {
    return Builder(
      key: key ?? ObjectKey(controller),
      builder: (context) {
        context.watch(controller);

        // 현재 열린 패널과 선택 영역에 적용된 서식 조회.
        final status = context.stateOf(() => GdsEditorStatus.none);
        final attributes = controller.getSelectionStyle().attributes;

        /// 서식의 선택 여부와 토글 동작을 툴바 항목으로 구성합니다.
        GdsEditorToolbarItem item(Attribute attribute) {
          return (
            selected: attributes[attribute.key]?.value == attribute.value,
            onChanged: (_) => controller.toggleFormat(attribute),
          );
        }

        /// 선택 영역의 색상 코드를 대응하는 디자인 시스템 색상 항목으로 변환합니다.
        GdsEditorFontColor? colorOf(Attribute attribute) {
          final value = attributes[attribute.key]?.value?.toString().toUpperCase();

          return .values.firstWhereOrNull(
            (color) => color.color.of(context).toHex() == value,
          );
        }

        return GdsEditorControls(
          status: status.value,
          toolbar: .new(
            bold: item(.bold),
            italic: item(.italic),
            underline: item(.underline),
            strikethrough: item(.strikeThrough),
            onChanged: (value) => status.value = status.value == value ? .none : value,
            onUndo: controller.undo,
            onRedo: controller.redo,
            onClose: () {
              // 옵션 패널과 키보드 닫기.
              status.value = .none;
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          panel: .new(
            fontStyle: switch (attributes[Attribute.header.key]?.value) {
              1 => .title1,
              2 => .title2,
              _ => .body,
            },
            fontColor: colorOf(.color),
            fontBgColor: colorOf(.background),
            onAddImage: () async {
              // 이미지 선택 중 커서가 이동해도 최초 선택 영역에 삽입.
              final selection = controller.selection;
              final url = await onAddImage();

              // 위젯이 제거되었거나 이미지 선택을 취소한 경우 종료.
              if (!context.mounted || url == null || url.isEmpty) return;

              // 반환된 이미지 URL을 선택한 위치에 삽입.
              controller.replaceText(
                selection.start,
                selection.end - selection.start,
                BlockEmbed.image(url),
                .collapsed(offset: selection.start + 1),
              );

              status.value = .none;
            },
            onAddLink: () async {
              // 링크 입력 전 선택한 텍스트 범위 유지.
              final selection = controller.selection;
              final link = await onAddLink();

              // 위젯이 제거되었거나 링크 입력을 취소한 경우 종료.
              if (!context.mounted || link == null || link.name.isEmpty || link.url.isEmpty) return;

              // 선택 영역을 링크 이름으로 교체하고 해당 주소 연결.
              controller.replaceText(
                selection.start,
                selection.end - selection.start,
                link.name,
                .collapsed(offset: selection.start + link.name.length),
              );

              controller.formatText(
                selection.start,
                link.name.length,
                LinkAttribute(link.url),
              );

              status.value = .none;
            },
            onFontStyleChanged: (value) {
              // 본문은 제목 서식을 제거하여 일반 문단으로 저장.
              controller.toggleFormat(
                switch (value) {
                  .title1 => .h1,
                  .title2 => .h2,
                  .body => .clone(.header, null),
                },
              );

              status.value = .none;
            },
            onFontColorChanged: (value) {
              // 글자색을 적용하고 옵션 패널 닫기.
              controller.toggleFormat(
                ColorAttribute(value.color.of(context).toHex()),
              );

              status.value = .none;
            },
            onFontBgColorChanged: (value) {
              // 글자 배경색을 적용하고 옵션 패널 닫기.
              controller.toggleFormat(
                BackgroundAttribute(value.color.of(context).toHex()),
              );

              status.value = .none;
            },
          ),
        );
      },
    );
  }
}
