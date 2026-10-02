import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 항목의 선택 여부를 사각형 체크 아이콘으로 표시하고 변경하는 위젯.
@GdsSupportedSizes([.md, .sm])
class GdsCheckBox extends StatelessWidget {
  const GdsCheckBox({
    super.key,
    required this.size,
    required this.value,
    this.enabled = true,
    this.onChanged,
  });

  final GdsSize size;
  final bool value;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final GdsIcon icon = value ? .checkSquareFill : .checkSquare;

    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsTransition.crossFade(
        animation: .fast,
        value: [value, enabled],
        child: icon.build(
          size: size.when(md: 24, sm: 16),
          color: GdsControl.colorOf(value, enabled),
        ),
      ),
    );
  }
}
