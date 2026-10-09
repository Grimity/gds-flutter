// ignore_for_file: gds_lints/prefer_gds_image

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 이미지 위젯.
class GdsImage extends StatelessWidget {
  const new({
    super.key,
    this.provider,
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
  final ImageProvider? placeholder;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// 네트워크 기반 이미지인 경우 캐시 키를 지정할 수 있습니다.
  /// 캐시 키를 지정하지 않으면 URL을 기반으로 캐시됩니다.
  final String? cacheKey;

  @override
  Widget build(BuildContext context) {
    // 이미지 로딩 중에 임시로 표시할 이미지.
    final placeholderProvider = placeholder ?? context.theme.defaultPlaceholder;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.constrainWidth(width ?? constraints.maxWidth);
        final h = constraints.constrainHeight(height ?? constraints.maxHeight);
        final size = Size(
          context.toPhysicalPixels(w),
          context.toPhysicalPixels(h),
        );

        assert(!size.isInfinite);
        final cacheWidth = size.width.ceil();

        // 리사이즈된 플레이스 홀더 이미지.
        final placeholderImage = ResizeImage.resizeIfNeeded(
          cacheWidth,
          null,
          placeholderProvider,
        );

        // 표시 크기에 맞춰 디코딩할 이미지.
        final resizedImage = ResizeImage.resizeIfNeeded(
          cacheWidth,
          null,
          provider ?? placeholderProvider,
        );

        return Image(
          image: resizedImage,
          fit: fit,
          width: w,
          height: h,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;

            // 본 이미지의 페이드 인이 끝날 때까지 플레이스홀더 유지.
            return GdsTransition.builder<double>(
              key: ValueKey(resizedImage),
              value: frame == null ? 0 : 1,
              child: child,
              builder: (context, opacity, child) {
                return Stack(
                  children: [
                    if (opacity < 1)
                      Image(
                        image: placeholderImage,
                        fit: fit,
                        width: w,
                        height: h,
                        excludeFromSemantics: true,
                      ),

                    Opacity(opacity: opacity, child: child),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
