import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 에디터 툴바 항목의 상태와 콜백을 지정하는 레코드.
typedef GdsEditorToolbarItem = ({
  bool selected,
  ValueChanged<bool> onChanged,
});

/// 에디터의 서식 및 편집 기능을 제공하는 툴바 위젯.
class GdsEditorToolbar extends StatelessWidget {
  const GdsEditorToolbar({
    super.key,
    required this.bold,
    required this.italic,
    required this.underline,
    required this.strikethrough,
    required this.onChanged,
    required this.onUndo,
    required this.onRedo,
    required this.onClose,
  });

  final GdsEditorToolbarItem bold;
  final GdsEditorToolbarItem italic;
  final GdsEditorToolbarItem underline;
  final GdsEditorToolbarItem strikethrough;
  final ValueChanged<GdsEditorStatus> onChanged;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final editor = context.findAncestorWidgetOfExactType<GdsEditor>();
    final status = editor?.status;
    if (status == null) {
      throw FlutterError(
        'GdsEditorToolbar는 GdsEditor 내부에서만 사용할 수 있습니다.'
        'GdsEditor의 toolbar 속성으로 전달해 주세요.',
      );
    }

    final divider = GdsDivider(
      variant: .secondary,
      vertical: true,
      extent: 22,
    );

    return GdsContainer(
      color: .surfaceBase,
      width: .infinity,
      height: GdsControlSize.md.value,
      border: .new(top: 1, color: .borderGraySubtler),
      padding: .symmetric(horizontal: 16),
      child: GdsMasking(
        child: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 10,
            children: divider.separated([
              group([
                // 그림 업로드, 링크 추가
                .new(
                  type: .radio,
                  icon: .plus,
                  selected: status == .plus,
                  onChanged: (_) => onChanged(.plus),
                ),

                // 뒤로가기
                .new(
                  type: .button,
                  icon: .undo,
                  selected: false,
                  onChanged: (_) => onUndo(),
                ),

                // 뒤로가기 취소
                .new(
                  type: .button,
                  icon: .redo,
                  selected: false,
                  onChanged: (_) => onRedo(),
                ),
              ]),
              group([
                // 폰트
                .new(
                  type: .radio,
                  icon: .head,
                  selected: status == .fontStyle,
                  onChanged: (_) => onChanged(.fontStyle),
                ),

                // 굵게
                .new(
                  type: .check,
                  icon: .bold,
                  selected: bold.selected,
                  onChanged: bold.onChanged,
                ),

                // 기울이기
                .new(
                  type: .check,
                  icon: .italic,
                  selected: italic.selected,
                  onChanged: italic.onChanged,
                ),

                // 밑줄
                .new(
                  type: .check,
                  icon: .underline,
                  selected: underline.selected,
                  onChanged: underline.onChanged,
                ),

                // 취소선
                .new(
                  type: .check,
                  icon: .strikeout,
                  selected: strikethrough.selected,
                  onChanged: strikethrough.onChanged,
                ),

                // 폰트 색상
                .new(
                  type: .radio,
                  icon: .fontColor,
                  selected: status == .fontColor,
                  onChanged: (_) => onChanged(.fontColor),
                ),

                // 폰트 배경색
                .new(
                  type: .radio,
                  icon: .fontBg,
                  selected: status == .fontBgColor,
                  onChanged: (_) => onChanged(.fontBgColor),
                ),

                // 관련 시트 닫기
                .new(
                  type: .button,
                  icon: .keyboardDown,
                  selected: false,
                  onChanged: (_) => onClose(),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  /// 주어진 [buttons]를 가로로 배치한 툴바 버튼 그룹.
  Widget group(List<GdsEditorToolbarButton> buttons) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 8,
      children: buttons,
    );
  }
}
