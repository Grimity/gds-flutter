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
  });

  final ImageProvider? provider;
  final ImageProvider? placeholder;
  final double? width;
  final double? height;
  final BoxFit fit;

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
        final cacheWidth = (size.width / 50).ceil() * 50;

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

        return ImmediateImage(
          provider: resizedImage,
          fit: fit,
          width: w,
          height: h,
          builder: (child, loaded, synchronous) {
            if (synchronous) return child;

            // 본 이미지의 페이드 인이 끝날 때까지 플레이스홀더 유지.
            return GdsTransition.builder<double>(
              key: ValueKey(resizedImage),
              value: loaded ? 1 : 0,
              child: child,
              builder: (context, opacity, child) {
                return Stack(
                  children: [
                    if (opacity < 1)
                      ImmediateImage(
                        provider: placeholderImage,
                        fit: fit,
                        width: w,
                        height: h,
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
