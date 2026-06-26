import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsSidebarNavigationSize {
  lg('Large', 300),
  md('Medium', 220);

  final String displayName;
  final double width;
  const GdsSidebarNavigationSize(this.displayName, this.width);
}

class GdsSidebarNavigationItem {
  const GdsSidebarNavigationItem({
    required this.icon,
    required this.label,
    this.dotPushBadge = false,
    this.dotPushBadgePosition = GdsDotPushBadgePosition.bottomRight,
    required this.onTap,
  });

  final GdsIcon icon;
  final String label;
  final bool dotPushBadge;
  final GdsDotPushBadgePosition dotPushBadgePosition;
  final VoidCallback onTap;
}

/// 디자인 시스템에 따라 구현된 Sidebar 컴포넌트입니다.
class GdsSidebarNavigation extends StatelessWidget {
  const GdsSidebarNavigation({
    super.key,
    required this.size,
    required this.userImageUrl,
    required this.userName,
    required this.userId,
    required this.followerCount,
    required this.followingCount,
    required this.menuItems,
    this.padding,
    this.onAvatarTap,
    this.onHandleTap,
    this.onNickNameTap,
    this.onFollowerTap,
    this.onFollowingTap,
    this.onTermsOfServiceTap,
    this.onPrivacyPolicyTap,
    this.onBusinessInfoTap,
    this.onSignOutTap,
  });

  final GdsSidebarNavigationSize size;
  final String? userImageUrl;
  final String userName;
  final String userId;
  final int followerCount;
  final int followingCount;
  final List<GdsSidebarNavigationItem> menuItems;
  final EdgeInsets? padding;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onHandleTap;
  final VoidCallback? onNickNameTap;
  final VoidCallback? onFollowerTap;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onTermsOfServiceTap;
  final VoidCallback? onPrivacyPolicyTap;
  final VoidCallback? onBusinessInfoTap;
  final VoidCallback? onSignOutTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    EdgeInsets padding = EdgeInsets.only(
      top: GdsSpacing.spacing12,
      left: GdsSpacing.spacing16,
      right: GdsSpacing.spacing16,
      bottom: GdsSpacing.spacing24,
    );

    if (this.padding != null) {
      padding += this.padding!;
    }

    return Container(
      width: size.width,
      color: colors.surface.base,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: GdsSpacing.spacing8,
            children: [
              GdsGesture(
                onTap: onAvatarTap,
                child: GdsPersonAvatar(
                  size: GdsAvatarSize.ml,
                  imageUrl: userImageUrl,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: GdsSpacing.spacing2,
                children: [
                  GdsGesture(
                    onTap: onNickNameTap,
                    child: Text(userName, style: GdsTypography.label3.copyWith(color: colors.text.grayBold)),
                  ),
                  GdsGesture(
                    onTap: onHandleTap,
                    child: Text(userId, style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                  ),
                ],
              ),
              GdsUserInfo.follow(
                followerCount: followerCount,
                followingCount: followingCount,
                onFollowerTap: onFollowerTap,
                onFollowingTap: onFollowingTap,
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing20),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return _TabMenu(item: menuItems[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: GdsSpacing.spacing8);
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: GdsSpacing.spacing12,
            children: [
              GdsTextButton(
                text: "로그아웃",
                trailingIcon: GdsIcon.signOut,
                onPressed: onSignOutTap,
                enabled: true,
                variant: GdsTextButtonVariant.assistive,
                size: GdsTextButtonSize.small,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: GdsSpacing.spacing4,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: GdsSpacing.spacing6,
                    children: [
                      GdsGesture(
                        onTap: onTermsOfServiceTap,
                        child: Text('이용약관', style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                      ),
                      GdsEllipse(),
                      GdsGesture(
                        onTap: onPrivacyPolicyTap,
                        child: Text('개인정보처리방침', style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                      ),
                    ],
                  ),
                  GdsGesture(
                    onTap: onBusinessInfoTap,
                    child: Text(
                      '사업자 정보',
                      style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
                    ),
                  ),
                  Text(
                    '© Grimity. All rights reserved.',
                    style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabMenu extends StatelessWidget {
  const _TabMenu({
    required this.item,
  });

  final GdsSidebarNavigationItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    final iconChild = item.icon.build(color: colors.icon.grayNormal);

    return GdsGesture(
      onTap: item.onTap,
      child: SizedBox(
        height: GdsSpacing.spacing40,
        child: Row(
          spacing: GdsSpacing.spacing8,
          children: [
            item.dotPushBadge ? GdsDotPushBadge(position: item.dotPushBadgePosition, child: iconChild) : iconChild,
            Text(item.label, style: GdsTypography.label1.copyWith(color: colors.text.grayNormal)),
          ],
        ),
      ),
    );
  }
}
