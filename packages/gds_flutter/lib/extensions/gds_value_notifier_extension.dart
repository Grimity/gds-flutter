import 'package:flutter/widgets.dart';

/// 디자인 시스템에서 제공하는 [ValueNotifier]에 대한 유틸리티 확장.
extension GdsFunctionExtension on ValueNotifier {
  /// 현재 불리언 값을 반전하고 해당 값을 반환합니다.
  bool toogle() {
    assert(value is bool);
    return value = !value;
  }
}
