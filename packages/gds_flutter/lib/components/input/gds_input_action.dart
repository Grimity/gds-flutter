import 'package:flutter/widgets.dart';

/// 입력 필드에 대한 주요 외형 및 동작을 정의하는 인터페이스.
class GdsInputAction {
  const new({
    this.placeholder,
    this.onSubmitted,
    this.onComplete,
    this.onChanged,
  });

  final String? placeholder;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onChanged;
}
