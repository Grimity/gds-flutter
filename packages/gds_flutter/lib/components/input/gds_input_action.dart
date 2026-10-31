// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';

/// 입력 필드에 대한 주요 외형 및 동작을 정의하는 인터페이스.
class GdsInputAction {
  const new({
    this.placeholder,
    this.onSubmitted,
    this.onComplete,
    this.onChanged,
    this.focusNode,
    this.controller,
  });

  final String? placeholder;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
}
