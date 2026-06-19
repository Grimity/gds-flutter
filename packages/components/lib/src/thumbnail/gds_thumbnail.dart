import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsThumbnailRatio {
  r1x1,
  r5x4,
  r4x3,
  r3x2,
  r16x10,
  r16x9,
  r2x1,
  r21x9,
  r4x1,
  r3x4;

  double get value => switch (this) {
    r1x1 => 1 / 1,
    r5x4 => 5 / 4,
    r4x3 => 4 / 3,
    r3x2 => 3 / 2,
    r16x10 => 16 / 10,
    r16x9 => 16 / 9,
    r2x1 => 2 / 1,
    r21x9 => 21 / 9,
    r4x1 => 4 / 1,
    r3x4 => 3 / 4,
  };

  String get label => switch (this) {
    r1x1 => '1/1',
    r5x4 => '5/4',
    r4x3 => '4/3',
    r3x2 => '3/2',
    r16x10 => '16/10',
    r16x9 => '16/9',
    r2x1 => '2/1',
    r21x9 => '21/9',
    r4x1 => '4/1',
    r3x4 => '3/4',
  };
}

class GdsThumbnail extends StatelessWidget {
  const GdsThumbnail({
    super.key,
    this.imageUrl,
    this.image,
    this.imageProvider,
    this.ratio = GdsThumbnailRatio.r1x1,
    this.borderRadius,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : assert(
         (imageUrl != null ? 1 : 0) + (image != null ? 1 : 0) + (imageProvider != null ? 1 : 0) == 1,
         'Exactly one of imageUrl, image, or imageProvider must be provided.',
       ),
       assert(width != null || height != null, 'Either width or height must be provided.'),
       assert(width == null || width > 0, 'width must be > 0 when provided.'),
       assert(height == null || height > 0, 'height must be > 0 when provided.');

  /// The URL of a network image.
  ///
  /// Exactly one of [imageUrl], [image], or [imageProvider] must be provided.
  final String? imageUrl;

  /// A Flutter image, such as one created with `Image.asset` or `Image.file`.
  ///
  /// The thumbnail uses the image's [Image.image] provider and applies its own
  /// dimensions, fit, loading, and error behavior.
  final Image? image;

  /// An image source such as [AssetImage], [FileImage], or [MemoryImage].
  ///
  /// Exactly one of [imageUrl], [image], or [imageProvider] must be provided.
  final ImageProvider<Object>? imageProvider;
  final GdsThumbnailRatio ratio;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final BoxFit fit;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: AspectRatio(
        aspectRatio: ratio.value,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: imageUrl != null ? _buildNetworkImage() : _buildProviderImage(),
        ),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      fit: fit,
      placeholder: placeholder ?? defaultPlaceholder,
      errorWidget: errorWidget ?? defaultErrorWidget,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeInOut,
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeInOut,
      placeholderFadeInDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildProviderImage() {
    final provider = imageProvider ?? image!.image;

    return Image(
      image: ResizeImage.resizeIfNeeded(memCacheWidth, memCacheHeight, provider),
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;

        return Stack(
          fit: StackFit.expand,
          children: [
            (placeholder ?? defaultPlaceholder)(context, ''),
            AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: child,
            ),
          ],
        );
      },
      errorBuilder: (context, error, _) {
        return (errorWidget ?? defaultErrorWidget)(context, '', error);
      },
    );
  }

  /// [GdsThumbnail]에 대한 [placeholder]의 기본 빌더입니다.
  Widget defaultPlaceholder(BuildContext context, String imageUrl) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final asset = isDark
        ? GdsImage.thumbnailPlaceholderDark.build(width: width, height: height, fit: fit)
        : GdsImage.thumbnailPlaceholderLight.build(width: width, height: height, fit: fit);

    return SizedBox(width: width, height: height, child: asset);
  }

  /// [GdsThumbnail]에 대한 [errorWidget]의 기본 빌더입니다.
  Widget defaultErrorWidget(BuildContext context, String imageUrl, Object _) {
    return defaultPlaceholder(context, imageUrl);
  }
}
