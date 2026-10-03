import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 에디터에서 선택한 툴의 옵션을 표시하는 패널 위젯.
class GdsEditorPanel extends StatelessWidget {
  const new({
    super.key,
    required this.fontStyle,
    required this.fontColor,
    required this.fontBgColor,
    required this.onAddImage,
    required this.onAddLink,
    required this.onFontStyleChanged,
    required this.onFontColorChanged,
    required this.onFontBgColorChanged,
  });

  final GdsEditorFontStyle? fontStyle;
  final GdsEditorFontColor? fontColor;
  final GdsEditorFontColor? fontBgColor;
  final VoidCallback onAddImage;
  final VoidCallback onAddLink;
  final ValueChanged<GdsEditorFontStyle> onFontStyleChanged;
  final ValueChanged<GdsEditorFontColor> onFontColorChanged;
  final ValueChanged<GdsEditorFontColor> onFontBgColorChanged;

  @override
  Widget build(BuildContext context) {
    final editor = context.findAncestorWidgetOfExactType<GdsEditor>();
    final status = editor?.status;
    if (status == null) {
      throw FlutterError(
        'GdsEditorPanel은 GdsEditor 내부에서만 사용할 수 있습니다.'
        'GdsEditor의 panel 속성으로 전달해 주세요.',
      );
    }

    return GdsContainer(
      key: ValueKey(status),
      height: 120,
      padding: .symmetric(horizontal: 20),
      alignment: .center,
      child: switch (status) {
        .none => throw StateError(''),
        .plus => buildPlus(context),
        .fontStyle => buildFontStyle(context),
        .fontColor => buildFontColor(context),
        .fontBgColor => buildFontBgColor(context),
      },
    );
  }

  /// 그림 업로드와 링크 추가 버튼이 포함된 패널.
  Widget buildPlus(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        // 그림 업로드
        Expanded(
          child: GdsEditorPanelButton.icon(
            icon: .camera,
            label: '그림 업로드',
            selected: false,
            onTap: onAddImage,
            maxWidth: .infinity,
          ),
        ),

        // 링크 추가
        Expanded(
          child: GdsEditorPanelButton.icon(
            icon: .link,
            label: '링크 추가',
            selected: false,
            onTap: onAddLink,
            maxWidth: .infinity,
          ),
        ),
      ],
    );
  }

  /// 글꼴 스타일에 대한 패널.
  Widget buildFontStyle(BuildContext context) {
    const values = GdsEditorFontStyle.values;

    return Row(
      mainAxisAlignment: .center,
      spacing: 8,
      children: values.builder((value) {
        return Flexible(
          child: GdsEditorPanelButton.text(
            typography: value.style,
            title: '가나다',
            label: value.label,
            selected: fontStyle == value,
            onTap: () => onFontStyleChanged(value),
          ),
        );
      }),
    );
  }

  /// 폰트 색상에 대한 그리드 형태의 패널.
  Widget buildFontColor(BuildContext context) {
    const values = GdsEditorFontColor.values;

    Widget buildItem(GdsEditorFontColor value) {
      return GdsEditorPanelButton.fontColor(
        color: value.color,
        selected: fontColor == value,
        onTap: () => onFontColorChanged(value),
      );
    }

    return Column(
      mainAxisAlignment: .center,
      spacing: 8,
      children: [
        // 첫 번째 줄 (7칸)
        Row(
          mainAxisAlignment: .center,
          spacing: 8,
          children: values.slice(0, 7).builder(buildItem),
        ),

        // 두 번째 줄 (7칸)
        Row(
          mainAxisAlignment: .center,
          spacing: 8,
          children: values.slice(7, 14).builder(buildItem),
        ),
      ],
    );
  }

  /// 폰트 배경색에 대한 그리드 형태의 패널.
  Widget buildFontBgColor(BuildContext context) {
    const values = GdsEditorFontColor.values;

    Widget buildItem(GdsEditorFontColor value) {
      return GdsEditorPanelButton.fontBgColor(
        backgroundColor: value.color,
        foregroundColor: value.foregroundColor,
        selected: fontBgColor == value,
        onTap: () => onFontBgColorChanged(value),
      );
    }

    return Column(
      mainAxisAlignment: .center,
      spacing: 8,
      children: [
        // 첫 번째 줄 (7칸)
        Row(
          mainAxisAlignment: .center,
          spacing: 8,
          children: values.slice(0, 7).builder(buildItem),
        ),

        // 첫 번째 줄 (7칸)
        Row(
          mainAxisAlignment: .center,
          spacing: 8,
          children: values.slice(7, 14).builder(buildItem),
        ),
      ],
    );
  }
}
