import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_components/src/common/widget/gds_ellipse.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsSidebarSize {
  lg('Large', 300),
  md('Medium', 220);

  final String displayName;
  final double width;
  const GdsSidebarSize(this.displayName, this.width);
}

class GdsSidebarItem {
  const GdsSidebarItem({
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
class GdsSidebar extends StatelessWidget {
  const GdsSidebar({
    super.key,
    required this.size,
    required this.userImageUrl,
    required this.userName,
    required this.userId,
    required this.followerCount,
    required this.followingCount,
    required this.menuItems,
  });

  final GdsSidebarSize size;
  final String? userImageUrl;
  final String userName;
  final String userId;
  final int followerCount;
  final int followingCount;
  final List<GdsSidebarItem> menuItems;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      width: size.width,
      padding: EdgeInsets.only(
        top: GdsSpacing.spacing12,
        left: GdsSpacing.spacing16,
        right: GdsSpacing.spacing16,
        bottom: GdsSpacing.spacing24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: GdsSpacing.spacing8,
            children: [
              GdsPersonAvatar(
                size: GdsAvatarSize.ml,
                imageUrl: userImageUrl,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: GdsSpacing.spacing2,
                children: [
                  Text(userName, style: GdsTypography.label3.copyWith(color: colors.text.grayBold)),
                  Text(userId, style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                ],
              ),
              Row(
                spacing: GdsSpacing.spacing8,
                children: [
                  _UserInfo(label: '팔로워', value: '$followerCount'),
                  _UserInfo(label: '팔로잉', value: '$followingCount'),
                ],
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
                onPressed: () {},
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
                      Text('이용약관', style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                      GdsEllipse(),
                      Text('개인정보처리방침', style: GdsTypography.label6.copyWith(color: colors.text.graySubtle)),
                    ],
                  ),
                  Text(
                    '사업자 정보',
                    style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
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

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: GdsSpacing.spacing2,
      children: [
        Text(label, style: GdsTypography.label6.copyWith(color: colors.text.grayNormal)),
        Text(value, style: GdsTypography.label5.copyWith(color: colors.text.grayBold)),
      ],
    );
  }
}

class _TabMenu extends StatelessWidget {
  const _TabMenu({
    required this.item,
  });

  final GdsSidebarItem item;

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
