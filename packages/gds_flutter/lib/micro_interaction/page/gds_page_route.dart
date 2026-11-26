// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:material_ui/material_ui.dart';

/// 디자인 시스템의 공통 화면 전환을 적용하는 페이지 라우트.
class GdsPageRoute<T> extends MaterialPageRoute<T> {
  new({
    required Widget child,
  }) : super(
         builder: (_) => child,
         settings: .new(name: child.runtimeType.toString()),
         allowSnapshotting: false,
       );
}
