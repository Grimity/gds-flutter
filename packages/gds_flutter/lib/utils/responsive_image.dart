import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// 원본 URL과 실제 픽셀 크기를 기반으로 사용할 이미지 URL을 결정하는 함수.
typedef ImageResolver = String Function(String url, Size size);

/// 표시 크기에 맞는 URL을 선택하고 네트워크 이미지를 캐싱하는 이미지.
class ResponsiveImage extends ImageProvider<NetworkImage> {
  const new(
    this.url, {
    this.resolver = defaultImageResolver,
  });

  final String url;
  final ImageResolver resolver;

  @override
  Future<NetworkImage> obtainKey(ImageConfiguration config) {
    final size = config.size;
    if (size == null) {
      throw StateError('ImageConfiguration에서 size가 지정되지 않았습니다.');
    }

    final dpr = config.devicePixelRatio ?? 1.0;
    final resolvedUrl = resolver(url, size * dpr);

    // 변환된 URL을 캐시 키로 사용하여 크기별 이미지가 섞이지 않도록 함.
    return SynchronousFuture(.new(resolvedUrl));
  }

  @override
  ImageStreamCompleter loadImage(
    NetworkImage key,
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
}
