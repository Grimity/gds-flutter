// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';

/// 디자인 시스템에서 제공하는 [ValueNotifier]에 대한 유틸리티 확장.
extension GdsValueNotifierExtension<T> on ValueNotifier {
  /// 현재 불리언 값을 반전하고 해당 값을 반환합니다.
  bool toogle() {
    assert(value is bool);
    return value = !value;
  }
}
