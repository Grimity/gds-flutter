// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:gds_flutter/gds_flutter.dart';

/// 기준 위젯 아래에 [GdsMenu]를 표시하는 팝오버 라우트입니다.
class GdsMenuRoute<T> extends GdsPopoverRoute<T> {
  new({
    required GdsMenuPosition position,
    required super.layerLink,
    required super.child,
  }) : super(
         followerAnchor: position.followerAnchor,
         targetAnchor: position.targetAnchor,
         offset: const .new(0, 8),
       );
}
