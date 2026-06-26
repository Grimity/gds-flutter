import 'package:flutter/material.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsUserCardType {
  defaultType,
  search,
  tagView;

  String get displayName => switch (this) {
    GdsUserCardType.defaultType => 'Default',
    GdsUserCardType.search => 'Search',
    GdsUserCardType.tagView => 'TagView',
  };
}

class GdsUserCardThumbnailData {
  const GdsUserCardThumbnailData({
    required this.imageUrl,
    this.isLiked = false,
    this.onLikeTap,
  });

  final String imageUrl;
  final bool isLiked;
  final VoidCallback? onLikeTap;
}

class GdsUserCard extends StatelessWidget {
  const GdsUserCard({
    super.key,
    required this.type,
    required this.nickname,
    this.profileImageUrl,
    this.coverImageUrl,
    this.description,
    this.tagLabel,
    this.followerCount = 0,
    this.followingCount,
    this.latestThumbnails = const [],
    this.actionLabel = '팔로우',
    this.isActionSoild = true,
    this.onActionPressed,
    this.onTap,
  }) : assert(
         type != GdsUserCardType.defaultType || latestThumbnails.length == 3,
         'defaultType은 latestThumbnails 3개가 필요합니다.',
       ),
       assert(
         type != GdsUserCardType.search || description != null,
         'search 타입은 description이 필요합니다.',
       ),
       assert(
         type != GdsUserCardType.tagView || tagLabel != null,
         'tagView 타입은 tagLabel이 필요합니다.',
       );

  static const double defaultWidth = 360;
  static const double tagViewWidth = 180;
  static const double tagViewHeight = 240;

  final GdsUserCardType type;
  final String nickname;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? description;
  final String? tagLabel;
  final int followerCount;
  final int? followingCount;
  final List<GdsUserCardThumbnailData> latestThumbnails;
  final String actionLabel;
  final bool isActionSoild;
  final VoidCallback? onActionPressed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = switch (type) {
      GdsUserCardType.defaultType => _DefaultUserCard(
        nickname: nickname,
        profileImageUrl: profileImageUrl,
        followerCount: followerCount,
        followingCount: followingCount ?? 0,
        latestThumbnails: latestThumbnails,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
      ),
      GdsUserCardType.search => _SearchUserCard(
        nickname: nickname,
        profileImageUrl: profileImageUrl,
        coverImageUrl: coverImageUrl,
        followerCount: followerCount,
        description: description!,
        actionLabel: actionLabel,
        isActionSolid: isActionSoild,
        onActionPressed: onActionPressed,
      ),
      GdsUserCardType.tagView => _TagViewUserCard(
        imageUrl: coverImageUrl,
        tagLabel: tagLabel!,
      ),
    };

    if (onTap == null) {
      return card;
    }

    return GdsGesture(onTap: onTap, child: card);
  }
}

class _DefaultUserCard extends StatelessWidget {
  const _DefaultUserCard({
    required this.nickname,
    required this.profileImageUrl,
    required this.followerCount,
    required this.followingCount,
    required this.latestThumbnails,
    required this.actionLabel,
    required this.onActionPressed,
  });

  final String nickname;
  final String? profileImageUrl;
  final int followerCount;
  final int followingCount;
  final List<GdsUserCardThumbnailData> latestThumbnails;
  final String actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return SizedBox(
      width: GdsUserCard.defaultWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface.base,
          borderRadius: BorderRadius.circular(GdsRadius.md),
          border: Border.all(color: colors.border.graySubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.all(GdsSpacing.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: GdsSpacing.spacing24,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: GdsSpacing.spacing12,
                children: [
                  Expanded(
                    child: Row(
                      spacing: GdsSpacing.spacing8,
                      children: [
                        GdsPersonAvatar(
                          size: GdsAvatarSize.md,
                          imageUrl: profileImageUrl,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: GdsSpacing.spacing2,
                            children: [
                              Text(
                                nickname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GdsTypography.label2.copyWith(
                                  color: colors.text.grayBold,
                                ),
                              ),
                              GdsUserInfo.follow(
                                followerCount: followerCount,
                                followingCount: followingCount,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GdsSolidButton(
                    text: actionLabel,
                    size: GdsSolidButtonSize.small,
                    onPressed: onActionPressed,
                  ),
                ],
              ),
              Row(
                spacing: GdsSpacing.spacing8,
                children: [
                  for (final thumbnail in latestThumbnails.take(3)) Expanded(child: _LatestThumbnail(data: thumbnail)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchUserCard extends StatelessWidget {
  const _SearchUserCard({
    required this.nickname,
    required this.profileImageUrl,
    required this.coverImageUrl,
    required this.followerCount,
    required this.description,
    required this.actionLabel,
    required this.isActionSolid,
    required this.onActionPressed,
  });

  final String nickname;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final int followerCount;
  final String description;
  final String actionLabel;
  final bool isActionSolid;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return SizedBox(
      width: GdsUserCard.defaultWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface.base,
          borderRadius: BorderRadius.circular(GdsRadius.md),
          border: Border.all(color: colors.border.graySubtle),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(GdsRadius.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GdsThumbnail(
                imageUrl: coverImageUrl ?? '',
                width: GdsUserCard.defaultWidth,
                ratio: GdsThumbnailRatio.r4x1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  GdsSpacing.spacing16,
                  0,
                  GdsSpacing.spacing16,
                  GdsSpacing.spacing16,
                ),
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: GdsSpacing.spacing12,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: GdsSpacing.spacing12,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: GdsSpacing.spacing8,
                              children: [
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(
                                      BorderSide(color: Colors.white, width: 4),
                                    ),
                                  ),
                                  child: GdsPersonAvatar(
                                    size: GdsAvatarSize.md,
                                    imageUrl: profileImageUrl,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: GdsSpacing.spacing2,
                                  children: [
                                    Text(
                                      nickname,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GdsTypography.label1.copyWith(
                                        color: colors.text.grayBold,
                                      ),
                                    ),
                                    GdsUserInfo.follow(followerCount: followerCount),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          if (isActionSolid) ...[
                            GdsSolidButton(
                              text: actionLabel,
                              size: GdsSolidButtonSize.small,
                              onPressed: onActionPressed,
                            ),
                          ] else ...[
                            GdsOutlinedButton(
                              text: actionLabel,
                              size: GdsOutlinedButtonSize.small,
                              onPressed: onActionPressed,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GdsTypography.body2R.copyWith(
                          color: colors.text.grayNormal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagViewUserCard extends StatelessWidget {
  const _TagViewUserCard({
    required this.imageUrl,
    required this.tagLabel,
  });

  final String? imageUrl;
  final String tagLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return SizedBox(
      width: GdsUserCard.tagViewWidth,
      height: GdsUserCard.tagViewHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(GdsRadius.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GdsThumbnail(
              imageUrl: imageUrl ?? '',
              width: GdsUserCard.tagViewWidth,
              height: GdsUserCard.tagViewHeight,
              ratio: GdsThumbnailRatio.r3x4,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    colors.bg.black.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            Positioned(
              left: GdsSpacing.spacing16,
              right: GdsSpacing.spacing16,
              bottom: GdsSpacing.spacing16,
              child: Text(
                tagLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GdsTypography.body1SB.copyWith(
                  color: colors.text.white,
                  shadows: [
                    const Shadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LatestThumbnail extends StatelessWidget {
  const _LatestThumbnail({required this.data});

  final GdsUserCardThumbnailData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(GdsRadius.sm),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GdsThumbnail(
                    imageUrl: data.imageUrl,
                    width: constraints.maxWidth,
                    ratio: GdsThumbnailRatio.r1x1,
                    borderRadius: BorderRadius.circular(GdsRadius.sm),
                  ),
                  Positioned(
                    right: GdsSpacing.spacing4,
                    bottom: GdsSpacing.spacing4,
                    child: GdsGesture(
                      onTap: data.onLikeTap,
                      child: SizedBox.square(
                        dimension: GdsIconSize.v20,
                        child: Center(
                          child: GdsHeart.icon(data.isLiked).build(
                            width: GdsIconSize.v20,
                            height: GdsIconSize.v20,
                            color: data.isLiked ? colors.status.notification : colors.icon.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
