import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 항목의 선택 여부를 원형 표시로 나타내고 변경하는 라디오 위젯.
class GdsRadio extends StatelessWidget {
  const GdsRadio({
    super.key,
    required this.value,
    this.enabled = true,
    this.onChanged,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  static const _outerSize = 20.0;
  static const _innerSize = 12.0;

  @override
  Widget build(BuildContext context) {
    final GdsColor color = GdsControl.colorOf(value, enabled);

    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsContainer(
        animation: .fast,
        width: _outerSize,
        height: _outerSize,
        shape: .circle,
        border: .all(width: 2, color: color),
        alignment: .center,
        child: GdsContainer(
          width: value ? _innerSize : 0,
          height: value ? _innerSize : 0,
          color: color,
          shape: .circle,
        ),
      ),
    );
  }
}
