// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [ThemeMode]에 대한 유틸리티 확장.
extension GdsThemeExtension on ThemeMode {
  /// 현재 시스템에서 설정된 화면 밝기 모드를 반환합니다.
  static Brightness get brightness {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  /// 테마 모드에 맞는 GDS 테마를 반환하며, 시스템 모드는 현재 시스템 밝기를 따릅니다.
  GdsTheme get theme {
    return switch (this) {
      .light => const .light(),
      .dark => const .dark(),
      .system => brightness == .dark ? const .dark() : const .light(),
    };
  }
}
