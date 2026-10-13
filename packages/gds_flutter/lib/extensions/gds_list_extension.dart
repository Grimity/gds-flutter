import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [List]에 대한 유틸리티 확장.
extension GdsListExtension<T> on List<T> {
  /// 각 요소에 [builder]를 적용한 위젯 목록을 반환합니다.
  List<R> builder<R>(R Function(T value) builder) {
    return map(builder).toList();
  }

  /// 각 요소의 인덱스와 값에 [builder]를 적용한 위젯 목록을 반환합니다.
  List<R> indexedBuilder<R>(R Function(int index, T value) builder) {
    return mapIndexed(builder).toList();
  }

  /// 이미지 URL 목록을 [ImageProvider] 목록으로 변환합니다.
  List<ImageProvider> toImages() {
    return builder((e) => (e as String).toImage());
  }
}
