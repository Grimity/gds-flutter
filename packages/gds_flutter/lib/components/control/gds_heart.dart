import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 좋아요의 선택 여부를 하트 아이콘으로 표시하고 변경하는 위젯.
class GdsHeart extends StatelessWidget {
  const new({
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
    return GdsGesture(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: GdsTransition.crossFade(
        animation: .fast,
        value: [value, black, enabled],
        child: Stack(
          children: [
            // 배경 아이콘 표시
            GdsIcon.heartFill.build(
              size: 24,
              color: value ? .statusNotification : .surfaceBase,
            ),

            // 전경 아이콘 표시
            if (!value) ...[
              GdsIcon.heart.build(
                size: 24,
                color: black ? .iconGrayBold : .iconGraySubtle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
