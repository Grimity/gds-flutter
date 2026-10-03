// ignore_for_file: gds_lints/prefer_gds_image

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 초기 이미지와 크기를 기반으로 사용할 최종 이미지를 결정하는 함수.
typedef ImageProviderResolver = ImageProvider Function(ImageProvider provider, Size size);

/// 디자인 시스템 전반에서 공통으로 사용하는 이미지 위젯.
class GdsImage extends StatelessWidget {
  const GdsImage({
    super.key,
    this.provider,
    this.resolver,
    this.placeholder,
    this.width,
    this.height,
    this.fit = .cover,
    this.cacheKey,
  }) : assert(
         provider is! NetworkImage ? cacheKey == null : true,
         'NetworkImage가 아닌 경우 cacheKey를 사용할 수 없습니다.',
       );

  final ImageProvider? provider;
  final ImageProviderResolver? resolver;
  final ImageProvider? placeholder;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// 네트워크 기반 이미지인 경우 캐시 키를 지정할 수 있습니다.
  /// 캐시 키를 지정하지 않으면 URL을 기반으로 캐시됩니다.
  final String? cacheKey;

  static const _fadeIn = GdsAnimation.normal;
  static const _fadeOut = GdsAnimation.normal;

  @override
  Widget build(BuildContext context) {
    // 이미지 로딩 중에 임시로 표시할 이미지.
    final placeholderProvider = placeholder ?? context.theme.defaultPlaceholder;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = width ?? constraints.maxWidth;
        final h = height ?? constraints.maxHeight;
        final size = Size(
          context.toPhysicalPixels(w),
          context.toPhysicalPixels(h),
        );

        assert(!size.isInfinite);
        final cacheWidth = size.width.ceil();

        ImageProvider? resolvedImage;

        // 리졸버가 있으면 현재 크기에 맞는 이미지로 변환할 수 있도록 함.
        if (provider != null) {
          resolvedImage = resolver?.call(provider!, size) ?? provider;
        }

        resolvedImage ??= placeholderProvider;

        // 리사이즈된 플레이스 홀더 이미지.
        final placeholderImage = ResizeImage.resizeIfNeeded(
          cacheWidth,
          null,
          placeholderProvider,
        );

        // 네트워크 기반 이미지인 경우 캐시된 네트워크 이미지를 사용.
        if (resolvedImage is NetworkImage) {
          return CachedNetworkImage(
            fadeInDuration: _fadeIn.duration,
            fadeInCurve: _fadeIn.curve,
            fadeOutDuration: _fadeOut.duration,
            fadeOutCurve: _fadeOut.curve,
            placeholder: (_, _) => Image(image: placeholderImage),
            imageUrl: resolvedImage.url,
            cacheKey: cacheKey,
            fit: fit,
            width: width ?? .infinity,
            height: height ?? .infinity,
            memCacheWidth: cacheWidth,
          );
        }

        // 리사이즈된 에셋 이미지.
        final resizedImage = ResizeImage.resizeIfNeeded(
          cacheWidth,
          null,
          resolvedImage,
        );

        return FadeInImage(
          fadeInDuration: _fadeIn.duration,
          fadeInCurve: _fadeIn.curve,
          fadeOutDuration: _fadeOut.duration,
          fadeOutCurve: _fadeOut.curve,
          placeholder: placeholderImage,
          image: resizedImage,
          fit: fit,
          width: width ?? .infinity,
          height: height ?? .infinity,
        );
      },
    );
  }
}
