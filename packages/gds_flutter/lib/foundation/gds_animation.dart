// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/animation.dart';

/// 디자인 시스템에서 사용하는 표준 애니메이션 속도.
enum GdsAnimation {
  fast(.new(milliseconds: 175)),
  normal(.new(milliseconds: 250)),
  slow(.new(milliseconds: 300)),
  slowest(.new(milliseconds: 400));

  const new(this.duration);

  /// 애니메이션 지속 시간.
  final Duration duration;

  /// 애니메이션에 적용되는 곡선.
  Curve get curve => Curves.ease;
}
