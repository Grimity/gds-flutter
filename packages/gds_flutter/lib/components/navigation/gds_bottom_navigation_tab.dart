import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 하단 내비게이션 탭의 아이콘, 라벨, 알림 점 표시 여부와 탭 콜백을 정의하는 클래스.
class GdsBottomNavigationTab {
  const GdsBottomNavigationTab({
    required this.icon,
    required this.label,
    this.showDot = false,
    required this.onTap,
  });

  final GdsIcon icon;
  final String label;
  final bool showDot;
  final VoidCallback onTap;

  /// 하단 내비게이션 탭 위젯을 빌드합니다.
  Widget build(bool selected) {
    return GdsGesture(
      onTap: onTap,
      child: Column(
        mainAxisSize: .min,
        spacing: 2,
        children: [
          // 아이콘 표시
          GdsPushBadge.dot(
            position: .bottomRight,
            visible: showDot,
            size: .sm,
            child: icon.build(
              size: 24,
              color: selected ? .iconGrayBold : .iconGraySubtle,
            ),
          ),

          // 라벨 표시
          GdsText(
            label,
            color: selected ? .textGrayBold : .textGraySubtle,
            style: .label6,
          ),
        ],
      ),
    );
  }
}
