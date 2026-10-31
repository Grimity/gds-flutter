// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [Color]에 대한 유틸리티 확장.
extension GdsColorExtension on Color {
  // Opacity
  Color get opacity80 => withAlpha(GdsOpacity.opacity80.alpha);
  Color get opacity60 => withAlpha(GdsOpacity.opacity60.alpha);
  Color get opacity40 => withAlpha(GdsOpacity.opacity40.alpha);
  Color get opacity20 => withAlpha(GdsOpacity.opacity20.alpha);
  Color get opacity10 => withAlpha(GdsOpacity.opacity10.alpha);
  Color get transparent => withAlpha(0);

  /// 알파 값을 제외한 16진수 색상 코드로 변환합니다.
  String toHex({bool includeHashSign = true}) {
    final rgb = toARGB32() & 0xFFFFFF;
    final hex = rgb.toRadixString(16).padLeft(6, '0').toUpperCase();

    return includeHashSign ? '#$hex' : hex;
  }

  /// 주어진 값이 null이 아닐 때만 [withAlpha]를 적용합니다.
  Color withAlphaIf(int? value) {
    return value != null ? withAlpha(value) : this;
  }
}
