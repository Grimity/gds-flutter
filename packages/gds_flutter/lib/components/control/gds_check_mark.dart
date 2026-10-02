import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 항목의 선택 여부를 체크 아이콘으로 표시하고 변경하는 위젯.
class GdsCheckMark extends StatelessWidget {
  const GdsCheckMark({
    super.key,
    required this.value,
    this.enabled = true,
    this.onChanged,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsIcon.check.build(
        size: 24,
        color: GdsControl.colorOf(value, enabled),
      ),
    );
  }
}
