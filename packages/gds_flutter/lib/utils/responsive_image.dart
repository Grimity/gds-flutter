// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// 원본 URL과 실제 픽셀 크기를 기반으로 사용할 이미지 URL을 결정하는 함수.
typedef ImageResolver = String Function(String url, Size size);

/// 표시 크기에 맞는 URL을 선택하고 네트워크 이미지를 캐싱하는 이미지.
class ResponsiveImage extends ImageProvider<CachedNetworkImageProvider> {
  const new(
    this.url, {
    this.cacheKey,
    this.resolver = defaultImageResolver,
  });

  final String url;
  final String? cacheKey;
  final ImageResolver resolver;

  /// URL에서 `너비x높이` 형식의 이미지 고유 크기를 추출합니다.
  Size get size {
    final match = RegExp(r'(\d+)x(\d+)').firstMatch(url);
    if (match == null) {
      throw StateError('URL에서 너비x높이 형식의 이미지 크기를 찾을 수 없습니다.');
    }

    return Size(
      .parse(match.group(1) ?? (throw StateError('URL에서 너비를 추출할 수 없습니다.'))),
      .parse(match.group(2) ?? (throw StateError('URL에서 높이를 추출할 수 없습니다.'))),
    );
  }

  /// 이미지 URL에서 저장 경로를 추출합니다.
  String get name {
    final segments = Uri.parse(url).pathSegments;
    return segments.sublist(segments.indexOf('v2')).join('/');
  }

  @override
  Future<CachedNetworkImageProvider> obtainKey(ImageConfiguration config) {
    final size = config.size;
    if (size == null) {
      throw StateError('ImageConfiguration에서 size가 지정되지 않았습니다.');
    }

    final dpr = config.devicePixelRatio ?? 1.0;
    final resolvedUrl = resolver(url, size * dpr);

    // 변환된 URL을 캐시 키로 사용하여 크기별 이미지가 섞이지 않도록 함.
    return SynchronousFuture(.new(resolvedUrl, cacheKey: cacheKey));
  }

  @override
  ImageStreamCompleter loadImage(
    CachedNetworkImageProvider key,
    ImageDecoderCallback decode,
  ) {
    return key.loadImage(key, decode);
  }

  /// 지원되는 너비를 기준으로 크기 조정용 새로운 이미지 URL을 반환합니다.
  static String defaultImageResolver(String url, Size size) {
    const supportResizeWidths = <int>[300, 600, 1200];
    final width = size.width;

    // 지원되는 리사이즈 크기 중 요청된 너비보다 크거나 같은 가장 작은 크기를 찾음.
    int closest = supportResizeWidths.firstWhere(
      (size) => size >= width,
      orElse: () => -1,
    );

    // 지원되는 리사이즈 크기보다 큰 경우.
    if (closest == -1) return url;

    final uri = Uri.parse(url);
    final query = {
      ...uri.queryParameters,
      's': closest.toString(),
    };

    return uri.replace(queryParameters: query).toString();
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ResponsiveImage && other.url == url && other.cacheKey == cacheKey;
  }

  @override
  int get hashCode => Object.hash(url, cacheKey);
}
