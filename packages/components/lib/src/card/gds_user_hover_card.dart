import 'package:flutter/material.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsUserHoverCardState { defaultType, follow }

class GdsUserHoverCard extends StatelessWidget {
  const GdsUserHoverCard({
    super.key,
    required this.nickname,
    this.profileImageUrl,
    this.coverImageUrl,
    this.bio,
    this.showContent = true,
    this.state = GdsUserHoverCardState.defaultType,
    this.onFollowPressed,
    this.onMessagePressed,
  });

  static const double frameWidth = 280;
  static const double minFrameHeight = 295;
  static const double coverHeight = 140;
  static const double contentTop = 108;
  static const double horizontalPadding = 24;
  static const double bottomPadding = 24;

  final String nickname;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? bio;
  final bool showContent;
  final GdsUserHoverCardState state;
  final VoidCallback? onFollowPressed;
  final VoidCallback? onMessagePressed;

  bool get hasBio => showContent && (bio?.trim().isNotEmpty ?? false);
  bool get isFollowState => state == GdsUserHoverCardState.follow;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return SizedBox(
      width: frameWidth,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: minFrameHeight),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface.base,
            borderRadius: BorderRadius.circular(GdsRadius.md),
            border: Border.all(color: colors.border.graySubtler),
            boxShadow: GdsShadows.level2,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(GdsRadius.md),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ColoredBox(color: colors.surface.base),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: _HoverCardCoverFrame(imageUrl: coverImageUrl),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    horizontalPadding,
                    contentTop,
                    horizontalPadding,
                    bottomPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _HoverCardAvatar(imageUrl: profileImageUrl),
                      const SizedBox(height: GdsSpacing.spacing16),
                      Text(
                        nickname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GdsTypography.subtitle1.copyWith(
                          color: colors.text.grayBold,
                        ),
                      ),
                      if (hasBio) ...[
                        const SizedBox(height: GdsSpacing.spacing6),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            bio!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: GdsTypography.body2R.copyWith(
                              color: colors.text.grayNormal,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: GdsSpacing.spacing16),
                      if (isFollowState)
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: GdsSolidButton(
                                text: '메시지 보내기',
                                size: GdsSolidButtonSize.regular,
                                expanded: true,
                                onPressed: onMessagePressed,
                              ),
                            ),
                            const SizedBox(width: GdsSpacing.spacing8),
                            Expanded(
                              flex: 5,
                              child: GdsOutlinedButton(
                                text: '팔로잉 중',
                                size: GdsOutlinedButtonSize.regular,
                                expanded: true,
                                onPressed: onFollowPressed,
                              ),
                            ),
                          ],
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          child: GdsSolidButton(
                            text: '팔로우',
                            size: GdsSolidButtonSize.regular,
                            expanded: true,
                            onPressed: onFollowPressed,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverCardCoverFrame extends StatelessWidget {
  const _HoverCardCoverFrame({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    final hasImage = (imageUrl ?? '').trim().isNotEmpty;

    return SizedBox(
      height: GdsUserHoverCard.coverHeight,
      child: hasImage
          ? GdsThumbnail(
              imageUrl: imageUrl!,
              width: GdsUserHoverCard.frameWidth,
              height: GdsUserHoverCard.coverHeight,
              ratio: GdsThumbnailRatio.r2x1,
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface.base,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ColoredBox(color: colors.surface.graySubtlest),
                      ),
                      Expanded(
                        child: ColoredBox(color: colors.surface.base),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, -0.25),
                    child: GdsIcon.logo.build(
                      width: 90,
                      color: colors.graphic.subtler,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _HoverCardAvatar extends StatelessWidget {
  const _HoverCardAvatar({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 4,
          ),
        ),
      ),
      child: GdsPersonAvatar(
        size: GdsAvatarSize.lg,
        imageUrl: imageUrl,
      ),
    );
  }
}
