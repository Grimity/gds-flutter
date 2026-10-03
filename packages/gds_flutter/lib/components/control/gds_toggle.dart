import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 기능의 켜짐 여부를 표시하고 변경하는 토글 스위치 위젯.
class GdsToggle extends StatelessWidget {
  const new({
    super.key,
    required this.value,
    this.enabled = true,
    this.onChanged,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  static const _outerSize = 32.0;
  static const _innerSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final GdsColor color = GdsControl.colorOf(value, enabled);

    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsContainer(
        animation: .fast,
        width: 52,
        height: _outerSize,
        color: color,
        radius: .full,
        padding: .all(4),
        alignment: value ? .centerRight : .centerLeft, // 상태에 따라 핸들을 양 끝에 배치.
        child: GdsContainer(
          width: _innerSize,
          height: _innerSize,
          color: .surfaceWhite,
          shape: .circle,
        ),
      ),
    );
  }
}
