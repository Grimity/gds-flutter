import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 아이콘과 라벨, 알림 점을 표시하는 사이드바 탭 위젯.
class GdsSidebarTab extends StatelessWidget {
  const new({
    super.key,
    required this.icon,
    required this.label,
    this.showDot = false,
    required this.onTap,
  });

  final GdsIcon icon;
  final String label;
  final bool showDot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: onTap,
      child: GdsContainer(
        alignment: .centerLeft,
        height: 40,
        child: Row(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            // 아이콘 표시
            GdsPushBadge.dot(
              position: .bottomRight,
              visible: showDot,
              size: .sm,
              child: icon.build(
                size: 32,
                color: .iconGrayNormal,
              ),
            ),

            // 라벨 표시
            GdsText(
              label,
              style: .label1,
              color: .textGrayNormal,
            ),
          ],
        ),
      ),
    );
  }
}
