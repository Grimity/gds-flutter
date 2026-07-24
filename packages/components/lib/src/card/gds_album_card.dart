import 'package:flutter/material.dart';
import 'package:gds_components/src/cell/gds_user_info.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_components/src/thumbnail/gds_thumbnail.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

/// 주어진 레이아웃 크기에 따른 적절한 이미지 URL을 반환하는 함수.
typedef GdsImageUrlBuilder = String Function(double width, double height);

enum GdsAlbumCardType { mainTitle, check, rank, image, imageUpload, album }

enum GdsAlbumCardState { defaultType, checked }

enum GdsAlbumCardImageSize {
  medium,
  large;

  double get width => switch (this) {
    GdsAlbumCardImageSize.medium => 160,
    GdsAlbumCardImageSize.large => 200,
  };
}

class GdsAlbumCard extends StatefulWidget {
  const GdsAlbumCard({
    super.key,
    this.imageUrl = '',
    this.image,
    this.imageProvider,
    this.imageUrlBuilder,
    this.title,
    this.nickname,
    this.heartCount,
    this.viewCount,
    this.timeText,
    this.showHeartButton = true,
    this.isLiked = false,
    this.state = GdsAlbumCardState.defaultType,
    this.type = GdsAlbumCardType.mainTitle,
    this.imageSize = GdsAlbumCardImageSize.large,
    this.rank = 1,
    this.albumBadgeText,
    this.primaryBadgeText = '대표',
    this.width,
    this.onTap,
    this.onHeartTap,
    this.onPrimaryBadgeTap,
    this.onCloseTap,
    this.onNicknameTap,
  }) : assert(
         (image == null && imageProvider == null && imageUrlBuilder == null) || imageUrl == '',
         'imageUrl cannot be combined with image, imageProvider, or imageUrlBuilder.',
       ),
       assert(
         (image != null ? 1 : 0) + (imageProvider != null ? 1 : 0) + (imageUrlBuilder != null ? 1 : 0) <= 1,
         'Only one of image, imageProvider, or imageUrlBuilder can be provided.',
       ),
       assert(width == null || width > 0, 'width must be greater than 0 when provided.'),
       assert(rank > 0, 'rank must be greater than 0.');

  static const double frameWidth = 160;

  final String imageUrl;
  final Image? image;
  final ImageProvider<Object>? imageProvider;
  final GdsImageUrlBuilder? imageUrlBuilder;
  final String? title;
  final String? nickname;
  final int? heartCount;
  final int? viewCount;
  final String? timeText;
  final bool showHeartButton;
  final bool isLiked;
  final GdsAlbumCardState state;
  final GdsAlbumCardType type;
  final GdsAlbumCardImageSize imageSize;
  final int rank;
  final String? albumBadgeText;
  final String primaryBadgeText;
  final double? width;
  final VoidCallback? onTap;
  final VoidCallback? onHeartTap;
  final VoidCallback? onPrimaryBadgeTap;
  final VoidCallback? onCloseTap;
  final VoidCallback? onNicknameTap;

  bool get hasTitle => title?.trim().isNotEmpty ?? false;

  bool get hasUserInfo => nickname?.trim().isNotEmpty ?? false;

  bool get isChecked => state == GdsAlbumCardState.checked;

  bool get showsInfoRow => switch (type) {
    GdsAlbumCardType.mainTitle || GdsAlbumCardType.check || GdsAlbumCardType.rank => true,
    GdsAlbumCardType.image || GdsAlbumCardType.imageUpload || GdsAlbumCardType.album => false,
  };

  bool get showsTitleRow => type != GdsAlbumCardType.album;

  bool get showsHeartOverlay => switch (type) {
    GdsAlbumCardType.mainTitle || GdsAlbumCardType.rank => showHeartButton,
    _ => false,
  };

  bool get showsCheckbox => type == GdsAlbumCardType.check;

  bool get showsRankBadge => type == GdsAlbumCardType.rank;

  bool get showsPrimaryBadge => type == GdsAlbumCardType.image || type == GdsAlbumCardType.imageUpload;

  bool get showsCloseButton => type == GdsAlbumCardType.image || type == GdsAlbumCardType.imageUpload;

  bool get showsAlbumCountBadge => type == GdsAlbumCardType.album && isChecked;

  double get resolvedWidth =>
      width ??
      ((type == GdsAlbumCardType.image || type == GdsAlbumCardType.imageUpload) ? imageSize.width : frameWidth);

  String get resolvedBadgeText {
    final text = albumBadgeText?.trim();
    return (text == null || text.isEmpty) ? 'N' : text;
  }

  @override
  State<GdsAlbumCard> createState() => _GdsAlbumCardState();
}

class _GdsAlbumCardState extends State<GdsAlbumCard> {
  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _AlbumThumbnail(
          imageUrlBuilder: (width, height) {
            return widget.imageUrlBuilder?.call(width, height) ?? widget.imageUrl;
          },
          image: widget.image,
          imageProvider: widget.imageProvider,
          width: widget.resolvedWidth,
          state: widget.state,
          type: widget.type,
          rank: widget.rank,
          showsHeartOverlay: widget.showsHeartOverlay,
          isLiked: widget.isLiked,
          albumBadgeText: widget.resolvedBadgeText,
          primaryBadgeText: widget.primaryBadgeText,
          onHeartTap: widget.onHeartTap,
          onPrimaryBadgeTap: widget.onPrimaryBadgeTap,
          onCloseTap: widget.onCloseTap,
        ),
        if (widget.showsTitleRow && widget.hasTitle) ...[
          const SizedBox(height: GdsSpacing.spacing8),
          Text(
            widget.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GdsTypography.label2.copyWith(color: context.gdsColors.text.grayBold),
          ),
        ],
        if (widget.showsInfoRow && widget.hasUserInfo) ...[
          const SizedBox(height: GdsSpacing.spacing4),
          GdsUserInfo.defaultType(
            nickName: widget.nickname!,
            onNameTap: widget.onNicknameTap,
            showHeart: widget.heartCount != null,
            heartCount: widget.heartCount,
            showView: widget.viewCount != null,
            viewCount: widget.viewCount,
            showTime: widget.timeText != null,
            timeText: widget.timeText,
          ),
        ],
      ],
    );

    return SizedBox(
      width: widget.resolvedWidth,
      child: widget.onTap == null ? content : GdsGesture(onTap: widget.onTap, child: content),
    );
  }
}

class _AlbumThumbnail extends StatelessWidget {
  const _AlbumThumbnail({
    required this.imageUrlBuilder,
    required this.image,
    required this.imageProvider,
    required this.width,
    required this.state,
    required this.type,
    required this.rank,
    required this.showsHeartOverlay,
    required this.isLiked,
    required this.albumBadgeText,
    required this.primaryBadgeText,
    required this.onHeartTap,
    required this.onPrimaryBadgeTap,
    required this.onCloseTap,
  });

  final GdsImageUrlBuilder imageUrlBuilder;
  final Image? image;
  final ImageProvider<Object>? imageProvider;
  final double width;
  final GdsAlbumCardState state;
  final GdsAlbumCardType type;
  final int rank;
  final bool showsHeartOverlay;
  final bool isLiked;
  final String albumBadgeText;
  final String primaryBadgeText;
  final VoidCallback? onHeartTap;
  final VoidCallback? onPrimaryBadgeTap;
  final VoidCallback? onCloseTap;

  bool get isChecked => state == GdsAlbumCardState.checked;
  bool get isImageChecked => type == GdsAlbumCardType.image && isChecked;
  bool get showsImagePill => type == GdsAlbumCardType.image || type == GdsAlbumCardType.imageUpload;
  bool get showsCloseButton => type == GdsAlbumCardType.image || type == GdsAlbumCardType.imageUpload;
  bool get showsRankBadge => type == GdsAlbumCardType.rank;
  bool get showsCheckbox => type == GdsAlbumCardType.check;
  bool get showsAlbumCountBadge => type == GdsAlbumCardType.album && isChecked;
  bool get showsFilledOverlay => (type == GdsAlbumCardType.check || type == GdsAlbumCardType.album) && isChecked;
  bool get showsImageBorder => type == GdsAlbumCardType.image && isChecked;
  bool get showsCheckBorder => type == GdsAlbumCardType.check;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final borderRadius = BorderRadius.circular(GdsRadius.md);

    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageUrl = imageUrlBuilder(constraints.maxWidth, constraints.maxHeight);
            final hasImage = imageUrl.trim().isNotEmpty || image != null || imageProvider != null;
            final showsUploadPlaceholder = type == GdsAlbumCardType.imageUpload && !hasImage;

            return Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: _border(colors),
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (showsUploadPlaceholder)
                      _ImageUploadPlaceholder(width: width)
                    else
                      GdsThumbnail(
                        imageUrl: image == null && imageProvider == null ? imageUrl : null,
                        image: image,
                        imageProvider: imageProvider,
                        width: width,
                        ratio: GdsThumbnailRatio.r1x1,
                        borderRadius: borderRadius,
                      ),
                    if (type == GdsAlbumCardType.mainTitle || type == GdsAlbumCardType.rank)
                      ColoredBox(color: colors.bg.black.withValues(alpha: 0.04)),
                    if (showsFilledOverlay)
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x661A1B1E), Color(0x001A1B1E)],
                          ),
                        ),
                      ),
                    if (showsRankBadge)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: _RankBadge(rank: rank),
                      ),
                    if (showsHeartOverlay)
                      Positioned(
                        right: GdsSpacing.spacing4,
                        bottom: GdsSpacing.spacing4,
                        child: _AlbumHeartButton(isLiked: isLiked, onTap: onHeartTap),
                      ),
                    if (showsCheckbox)
                      Positioned(
                        top: GdsSpacing.spacing8,
                        right: GdsSpacing.spacing8,
                        child: _CheckIndicator(isChecked: isChecked),
                      ),
                    if (showsAlbumCountBadge)
                      Positioned(
                        top: GdsSpacing.spacing8,
                        right: GdsSpacing.spacing8,
                        child: _AlbumCountBadge(text: albumBadgeText),
                      ),
                    if (showsImagePill && !showsUploadPlaceholder)
                      Positioned(
                        top: isImageChecked ? 6 : 8,
                        left: isImageChecked ? 6 : 8,
                        child: _PrimaryImageBadge(
                          text: primaryBadgeText,
                          isChecked: isImageChecked,
                          onTap: onPrimaryBadgeTap,
                        ),
                      ),
                    if (showsCloseButton && !showsUploadPlaceholder)
                      Positioned(
                        top: isImageChecked ? 6 : 8,
                        right: isImageChecked ? 6 : 8,
                        child: _ImageCloseButton(onTap: onCloseTap),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Border? _border(GdsSemanticColor colors) {
    if (showsImageBorder) {
      return Border.all(color: colors.border.primaryNormal, width: 2);
    }

    if (showsCheckBorder) {
      return Border.all(
        color: isChecked ? colors.border.primaryNormal : colors.border.graySubtle,
        width: 2,
      );
    }

    return null;
  }
}

class _ImageUploadPlaceholder extends StatelessWidget {
  const _ImageUploadPlaceholder({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final iconSize = width <= GdsAlbumCard.frameWidth ? 54.0 : 64.0;
    final topGap = width <= GdsAlbumCard.frameWidth ? GdsSpacing.spacing10 : GdsSpacing.spacing12;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.graySubtlest,
        border: Border.all(color: colors.border.graySubtler),
        borderRadius: BorderRadius.circular(GdsRadius.md),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GdsIcon.galleryOutline.build(
                width: iconSize,
                height: iconSize,
                color: colors.icon.graySubtler,
              ),
              SizedBox(height: topGap),
              Text(
                'JPG / PNG',
                textAlign: TextAlign.center,
                style: GdsTypography.label3.copyWith(color: colors.text.graySubtle),
              ),
              const SizedBox(height: GdsSpacing.spacing2),
              Text(
                '1장 당 10MB 이내',
                textAlign: TextAlign.center,
                style: GdsTypography.subtitle3.copyWith(color: colors.text.graySubtle),
              ),
              const SizedBox(height: GdsSpacing.spacing2),
              Text(
                '최대 10장까지 업로드',
                textAlign: TextAlign.center,
                style: GdsTypography.subtitle3.copyWith(color: colors.text.graySubtle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlbumHeartButton extends StatelessWidget {
  const _AlbumHeartButton({
    required this.isLiked,
    required this.onTap,
  });

  final bool isLiked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    final Widget child;

    if (isLiked) {
      child = GdsIcon.heartFill.build(
        width: GdsIconSize.v24,
        height: GdsIconSize.v24,
        color: colors.status.notification,
      );
    } else {
      child = Stack(
        children: [
          GdsIcon.heartFill.build(
            width: GdsIconSize.v24,
            height: GdsIconSize.v24,
            color: colors.icon.white,
          ),
          GdsIcon.heartOutline.build(
            width: GdsIconSize.v24,
            height: GdsIconSize.v24,
            color: colors.icon.graySubtle,
          ),
        ],
      );
    }

    return GdsGesture(onTap: onTap, child: child);
  }
}

class _CheckIndicator extends StatelessWidget {
  const _CheckIndicator({required this.isChecked});

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = (isChecked ? GdsIcon.checkSquareFill : GdsIcon.checkSquareOutline).build(
      width: GdsIconSize.v24,
      height: GdsIconSize.v24,
      color: isChecked ? colors.icon.primaryNormal : colors.icon.graySubtler,
    );

    return SizedBox(width: GdsIconSize.v24, height: GdsIconSize.v24, child: icon);
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  GdsIcon get icon => switch (rank) {
    1 => GdsIcon.rank1,
    2 => GdsIcon.rank2,
    3 => GdsIcon.rank3,
    _ => GdsIcon.rank4,
  };

  @override
  Widget build(BuildContext context) {
    return icon.build(width: GdsIconSize.v24, height: GdsIconSize.v24);
  }
}

class _PrimaryImageBadge extends StatelessWidget {
  const _PrimaryImageBadge({
    required this.text,
    required this.isChecked,
    required this.onTap,
  });

  final String text;
  final bool isChecked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final foregroundColor = isChecked ? colors.text.inverse : colors.text.graySubtle;
    final backgroundColor = isChecked ? colors.surface.primaryNormal : colors.surface.base;
    final borderColor = isChecked ? null : colors.border.graySubtler;

    final child = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(GdsRadius.full),
        border: borderColor == null ? null : Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isChecked ? GdsSpacing.spacing8 : GdsSpacing.spacing10,
          vertical: isChecked ? GdsSpacing.spacing4 : GdsSpacing.spacing6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GdsIcon.check.build(
              width: isChecked ? GdsIconSize.v12 : GdsIconSize.v16,
              height: isChecked ? GdsIconSize.v12 : GdsIconSize.v16,
              color: foregroundColor,
            ),
            const SizedBox(width: GdsSpacing.spacing2),
            Text(
              text,
              style: (isChecked ? GdsTypography.label6 : GdsTypography.label4).copyWith(
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );

    return onTap == null ? child : GdsGesture(onTap: onTap, child: child);
  }
}

class _ImageCloseButton extends StatelessWidget {
  const _ImageCloseButton({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final child = Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: colors.bg.overlayBlack,
        borderRadius: BorderRadius.circular(GdsRadius.sm),
      ),
      child: Center(
        child: GdsIcon.xMark.build(
          width: GdsIconSize.v16,
          height: GdsIconSize.v16,
          color: colors.icon.white,
        ),
      ),
    );

    return onTap == null ? child : GdsGesture(onTap: onTap, child: child);
  }
}

class _AlbumCountBadge extends StatelessWidget {
  const _AlbumCountBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.base,
        borderRadius: BorderRadius.circular(GdsRadius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing6),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 20),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GdsTypography.label5.copyWith(color: colors.text.grayBold),
            ),
          ),
        ),
      ),
    );
  }
}
