// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 다크 모드에 사용할 테마.
class GdsDarkTheme extends GdsTheme {
  const new();

  @override
  String get name => 'dark';

  @override
  GdsSemanticColor get semantic => .dark();

  @override
  ImageProvider get defaultPlaceholder => AssetImage(
    'assets/images/placeholder/dark.png',
    package: 'gds_flutter',
  );

  @override
  ImageProvider get profilePlaceholder => AssetImage(
    'assets/images/placeholder/profile/dark.png',
    package: 'gds_flutter',
  );
}
