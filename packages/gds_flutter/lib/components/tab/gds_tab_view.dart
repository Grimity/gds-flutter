// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 탭 화면의 공통 속성을 정의하는 믹스인.
mixin GdsTabView on Widget {
  /// 탭에 표시될 라벨.
  String get label;

  /// 탭에 표시할 개수.
  int? get count => null;

  /// 대응하는 탭 항목을 반환합니다.
  GdsTabItem get item => .new(label: label, count: count);
}

/// 탭 화면 목록에 대한 유틸리티 확장.
extension GdsTabViewExtension on List<GdsTabView> {
  /// 각 탭 화면의 대응하는 탭 항목 목록을 반환합니다.
  List<GdsTabItem> get items {
    return builder((view) => view.item);
  }
}
