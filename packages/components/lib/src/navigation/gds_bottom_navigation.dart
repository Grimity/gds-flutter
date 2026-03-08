import 'package:flutter/widgets.dart';
import 'package:gds_components/src/base/base.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 디자인 시스템에 따라 구현된 Bottom Navigation 컴포넌트입니다.
class GdsBottomNavigation {
  const GdsBottomNavigation._();

  static Widget main({
    Key? key,
    int? index,
    int? dotIndex,
  }) {
    return _BottomNavigation(
      key: key,
      index: index,
      onPressed: (index) => debugPrint('Selected index: $index'),
      items: [
        GdsBottomNavigationItem(icon: GdsIcon.home, label: '홈', isPush: dotIndex == 0),
        GdsBottomNavigationItem(icon: GdsIcon.paint, label: '랭킹', isPush: dotIndex == 1),
        GdsBottomNavigationItem(icon: GdsIcon.following, label: '팔로잉', isPush: dotIndex == 2),
        GdsBottomNavigationItem(icon: GdsIcon.board, label: '자유게시판', isPush: dotIndex == 3),
        GdsBottomNavigationItem(icon: GdsIcon.message, label: 'DM', isPush: dotIndex == 4),
      ],
    );
  }

  static Widget wrap({
    Key? key,
    required Widget child,
    required Widget navigation,
    VoidCallback? onPlusTap,
    GdsPlusState? plusState,
  }) {
    assert(
      onPlusTap == null || plusState != null,
      '플러스 버튼이 필요한 경우 plusState를 제공해야 합니다.',
    );

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              child,

              // 플러스 버튼이 필요한 경우에만 Positioned 위젯을 추가합니다.
              if (onPlusTap != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(GdsSpacing.spacing16),
                    child: _PlusButton(state: plusState!, onTap: onPlusTap),
                  ),
                ),
            ],
          ),
        ),
        navigation,
      ],
    );
  }
}

/// Bottom Navigation 컴포넌트의 각각의 목록 아이템을 나타냅니다.
class GdsBottomNavigationItem {
  const GdsBottomNavigationItem({
    required this.icon,
    required this.label,
    this.isPush = false,
  });

  final GdsIcon icon;
  final String label;
  final bool isPush;

  /// 해당 아이템을 적절한 [_Badge] 위젯으로 빌드합니다.
  Widget build({
    Key? key,
    required bool isPressed,
    required VoidCallback onPressed,
  }) {
    return _Badge(
      key: key,
      icon: icon,
      label: label,
      state: isPressed ? _BadgeState.pressed : _BadgeState.enabled,
      isPush: isPush,
      onPressed: onPressed,
    );
  }
}

/// Bottom Navigation의 Badge 상태를 나타냅니다.
enum _BadgeState {
  enabled,
  pressed,
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Bottom Navigation의 Badge입니다.
class _Badge extends StatelessWidget {
  const _Badge({
    super.key,
    required this.icon,
    required this.label,
    required this.state,
    required this.isPush,
    required this.onPressed,
  });

  final GdsIcon icon;
  final String label;
  final _BadgeState state;
  final bool isPush;
  final VoidCallback onPressed;

  /// [isPush]가 참일 경우 아이콘의 어느 위치에 Dot을 표시할지 결정하는 상수입니다.
  static final GdsDotPushBadgePosition _pushBadgePosition = GdsDotPushBadgePosition.bottomRight;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = switch (state) {
      _BadgeState.enabled => context.gdsColors.text.graySubtle,
      _BadgeState.pressed => context.gdsColors.text.grayBold,
    };

    // 아이콘 위에 Dot을 표시하는 경우와 그렇지 않은 경우 모두 동일한 아이콘 위젯을 사용합니다.
    final iconWidget = icon.build(color: foregroundColor);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(top: GdsSpacing.spacing2),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: GdsSpacing.spacing2,
          children: [
            isPush
                ? GdsDotPushBadge.small(position: _pushBadgePosition, child: iconWidget)
                : iconWidget,
            Text(
              label,
              style: GdsTypography.label6.copyWith(color: foregroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Bottom Navigation의 전체 레이아웃입니다.
class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    super.key,
    required this.items,
    required this.index,
    required this.onPressed,
  });

  /// Bottom Navigation에 표시될 아이템 목록입니다.
  final List<GdsBottomNavigationItem> items;

  /// 현재 선택된 아이템의 인덱스입니다.
  final int? index;

  /// 아이템이 선택되었을 때 호출되는 콜백 함수입니다.
  /// 인자로 선택된 아이템의 인덱스가 전달됩니다.
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        final index = items.indexOf(item);
        return Expanded(
          child: item.build(
            isPressed: index == this.index,
            onPressed: () => onPressed(index),
          ),
        );
      }).toList(),
    );
  }
}

/// Bottom Navigation의 Badge 상태를 나타냅니다.
enum GdsPlusState {
  enabled("Enabled"),
  pressed("Pressed");

  final String displayName;
  const GdsPlusState(this.displayName);
}

/// 해당 위젯은 디자인 시스템에 따라 구현된 Bottom Navigation의 플러스 버튼입니다.
class _PlusButton extends StatelessWidget {
  const _PlusButton({
    super.key,
    required this.state,
    required this.onTap,
  });

  final GdsPlusState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: switch (state) {
            GdsPlusState.enabled => colors.surface.primaryNormal,
            GdsPlusState.pressed => colors.surface.black,
          },
          boxShadow: GdsShadows.level2,
        ),
        child: GdsIcon.plus.build(color: colors.icon.white),
      ),
    );
  }
}
