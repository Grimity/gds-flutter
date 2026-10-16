import 'package:flutter/widgets.dart';

/// 디자인 시스템에서 제공하는 [ValueNotifier]에 대한 유틸리티 확장.
extension GdsValueNotifierExtension<T> on ValueNotifier {
  /// 현재 불리언 값을 반전하고 해당 값을 반환합니다.
  bool toogle() {
    assert(value is bool);
    return value = !value;
  }

  /// 주어진 값으로 해당 값을 정의합니다.
  void setter(T newValue) => value = newValue;
}

/// 디자인 시스템에서 제공하는 [ValueNotifier]의 제네릭 [List]에 대한 유틸리티 확장.
extension GdsValueNotifierListExtension<T> on ValueNotifier<List<T>> {
  /// 리스트 끝에 요소를 추가하고 변경을 알립니다.
  void add(T element) {
    value = [...value, element];
  }

  /// 일치하는 첫 번째 요소를 제거하고 변경을 알립니다.
  void remove(T element) {
    value = List.of(value)..remove(element);
  }

  /// 지정한 인덱스의 요소를 제거하고 변경을 알립니다.
  void removeAt(int index) {
    value = List.of(value)..removeAt(index);
  }
}
