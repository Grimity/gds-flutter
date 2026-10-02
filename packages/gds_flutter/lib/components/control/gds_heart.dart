import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 좋아요의 선택 여부를 하트 아이콘으로 표시하고 변경하는 위젯.
class GdsHeart extends StatelessWidget {
  const GdsHeart({
    super.key,
    required this.value,
    required this.black,
    this.enabled = true,
    this.onChanged,
  });

  final bool value;
  final bool black;
  final bool enabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final GdsIcon icon = value ? .heartFill : .heart;

    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsTransition.crossFade(
        animation: .fast,
        value: [value, black, enabled],
        child: icon.build(
          size: 24,
          color: value ? .statusNotification : (black ? .iconGrayBold : .iconGraySubtle),
        ),
      ),
    );
  }
}
