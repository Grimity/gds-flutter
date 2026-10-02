import 'package:flutter/rendering.dart';

/// 디자인 시스템에서 제공하는 [String]에 대한 유틸리티 확장.
extension GdsStringExtension on String {
  /// n.b. 문자열이 오직 이미지 링크일 경우만 사용하세요.
  NetworkImage get networkImage => NetworkImage(this);
}
