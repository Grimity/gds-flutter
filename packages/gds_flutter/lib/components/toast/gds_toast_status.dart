// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:gds_flutter/gds_flutter.dart';

/// 토스트 메시지의 상태와 상태별 아이콘 및 색상을 정의하는 열거형.
enum GdsToastStatus {
  none(null, .iconWhite),
  positive(.checkCircleFill, .statusPositive),
  negative(.dangerCircleFill, .statusNegative),
  cautionary(.dangerTriangleFill, .statusCautionary),
  info(.infoCircleFill, .statusInfo);

  const new(this.icon, this.color);

  final GdsIcon? icon;
  final GdsColor color;
}
