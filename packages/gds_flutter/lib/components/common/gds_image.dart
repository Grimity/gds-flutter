// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

// ignore_for_file: gds_lints/prefer_gds_image

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

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
        var w = constraints.constrainWidth(width ?? constraints.maxWidth);
        var h = constraints.constrainHeight(height ?? constraints.maxHeight);

        // 한쪽 크기만 정해진 반응형 이미지는 원본 비율로 나머지 크기를 계산.
        final image = provider;
        if (image is ResponsiveImage) {
          if (w.isFinite && !h.isFinite) {
            h = constraints.constrainHeight(w / image.size.aspectRatio);
          } else if (h.isFinite && !w.isFinite) {
            w = constraints.constrainWidth(h * image.size.aspectRatio);
          }
        }

        final size = Size(
          context.toPhysicalPixels(w),
          context.toPhysicalPixels(h),
        );

        if (size.isInfinite) {
          throw StateError(
            '부모 크기를 참조할 수 없어 이미지의 크기를 결정할 수 없습니다. '
            '유한한 크기 제약을 제공하거나 width와 height를 지정해주세요.',
          );
        }

        // 드래그 등으로 표시 영역이 사라진 경우 이미지 요청 생략.
        if (size.isEmpty) {
          return SizedBox(width: w, height: h);
        }

        // 이미지 캐시 재사용을 위해 크기를 100픽셀 단위로 올림.
        final cacheWidth = (size.width / 100).ceil() * 100;
        final cacheHeight = (size.height / 100).ceil() * 100;

        ImageProvider resolvedImage = provider ?? placeholderProvider;

        // 기기 사진은 표시 크기에 알맞은 크기의 섬네일로 요청.
        if (resolvedImage is AssetEntityImageProvider) {
          resolvedImage = .new(
            resolvedImage.entity,
            isOriginal: false,
            thumbnailSize: .new(cacheWidth, cacheHeight),
            thumbnailFormat: .jpeg,
          );
        }

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
          resolvedImage,
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
