import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 에디터 툴바 버튼의 선택 방식을 나타내는 열거형.
enum GdsEditorToolbarButtonType {
  button, // 선택 불가
  radio, // 단일 선택
  check, // 복수 선택
}

/// 에디터의 서식 및 편집 동작을 수행하는 툴바 버튼 위젯.
class GdsEditorToolbarButton extends StatelessWidget {
  const GdsEditorToolbarButton({
    super.key,
    required this.type,
    required this.icon,
    required this.selected,
    this.color,
    required this.onChanged,
  });

  final GdsEditorToolbarButtonType type;
  final GdsIcon icon;
  final bool selected;
  final GdsColor? color;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    assert(type != .button || !selected);

    // 별도로 지정된 색상이 있는지 여부.
    final hasColor = color != null;

    // 버튼의 배경 색상.
    final GdsColor? backgroundColor = switch (type) {
      .button => null,
      .radio => selected ? .surfaceGraySubtler : null,
      .check => selected ? .surfaceGrayBold : null,
    };

    // 버튼의 아이콘 색상.
    final GdsColor iconColor = switch (type) {
      .button => .iconGrayBold,
      .radio => .iconGrayBold,
      .check => selected ? .iconInverse : .iconGrayBold,
    };

    return GdsGesture(
      onTap: () => onChanged(!selected),
      child: GdsContainer(
        padding: .all(4),
        radius: .xs,
        color: backgroundColor,
        child: icon.build(
          size: 24,
          color: icon.type == .semantic ? iconColor : null,
          colorMap: hasColor ? {'color': color!} : null,
        ),
      ),
    );
  }
}
