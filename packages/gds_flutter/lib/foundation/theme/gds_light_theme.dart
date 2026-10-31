// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 라이트 모드에 사용할 테마.
class GdsLightTheme extends GdsTheme {
  const new();

  @override
  String get name => 'light';

  @override
  GdsSemanticColor get semantic => .light();

  @override
  ImageProvider get defaultPlaceholder => AssetImage(
    'assets/images/placeholder/light.png',
    package: 'gds_flutter',
  );

  @override
  ImageProvider get profilePlaceholder => AssetImage(
    'assets/images/placeholder/profile/light.png',
    package: 'gds_flutter',
  );
}
