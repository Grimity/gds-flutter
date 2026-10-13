import 'package:flutter/rendering.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

/// 디자인 시스템에서 제공하는 [String]에 대한 유틸리티 확장.
extension GdsStringExtension on String {
  /// n.b. 문자열이 오직 이미지 링크일 경우만 사용하세요.
  ImageProvider get networkImage {
    return isEmpty ? MemoryImage(kTransparentImage) : NetworkImage(this);
  }

  /// 이미지 URL을 [ImageProvider]로 변환하며, 빈 문자열은 투명 이미지로 처리합니다.
  ImageProvider toImage() {
    return isEmpty ? MemoryImage(kTransparentImage) : ResponsiveImage(this);
  }
}
