part of '../gds_user_info.dart';

class GdsFollowUserInfo extends GdsUserInfo {
  final int followerCount;
  final VoidCallback? onFollowerTap;
  final bool showFollowing;
  final int? followingCount;
  final VoidCallback? onFollowingTap;

  const GdsFollowUserInfo({
    super.key,
    required this.followerCount,
    this.onFollowerTap,
    required this.showFollowing,
    this.followingCount,
    this.onFollowingTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      children: [
        GestureDetector(
          onTap: onFollowerTap,
          child: Row(
            children: [
              Text(
                '팔로워',
                style: GdsTypography.label6.copyWith(color: colors.text.grayNormal),
              ),
              const SizedBox(width: GdsSpacing.spacing2),
              Text(
                '$followerCount',
                style: GdsTypography.label5.copyWith(color: colors.text.grayBold),
              ),
            ],
          ),
        ),
        if (showFollowing && followingCount != null) ...[
          const SizedBox(width: GdsSpacing.spacing8),
          GestureDetector(
            onTap: onFollowingTap,
            child: Row(
              children: [
                Text(
                  '팔로잉',
                  style: GdsTypography.label6.copyWith(color: colors.text.grayNormal),
                ),
                const SizedBox(width: GdsSpacing.spacing2),
                Text(
                  '$followingCount',
                  style: GdsTypography.label5.copyWith(color: colors.text.grayBold),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
