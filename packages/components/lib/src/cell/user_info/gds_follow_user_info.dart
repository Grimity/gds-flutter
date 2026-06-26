part of '../gds_user_info.dart';

class GdsFollowUserInfo extends GdsUserInfo {
  final int followerCount;
  final VoidCallback? onFollowerTap;
  final int? followingCount;
  final VoidCallback? onFollowingTap;

  const GdsFollowUserInfo({
    super.key,
    required this.followerCount,
    this.onFollowerTap,
    this.followingCount,
    this.onFollowingTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: GdsSpacing.spacing8,
      children: [
        GdsGesture(
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
        if (followingCount != null) ...[
          GdsGesture(
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
