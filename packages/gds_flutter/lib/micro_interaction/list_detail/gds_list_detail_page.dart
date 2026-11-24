// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 목록에서 선택할 상세 페이지의 공통 속성을 정의하는 믹스인.
mixin GdsListDetailPage on Widget {
  /// 목록 항목에 표시할 아이콘.
  GdsIcon get icon;

  /// 목록 항목에 표시할 라벨 및 제목.
  String get title;

  /// 기기 유형과 관계없이 페이지를 감싸지 않고 항상 라우트로 여는지 여부.
  bool get pushDirectly => false;

  /// 상세 콘텐츠를 상단 내비게이션이 있는 모바일 페이지로 구성합니다.
  Widget buildView(BuildContext context) {
    return GdsScaffold(
      appBar: GdsTopNavigation.iconButton(
        onBack: context.pop,
        title: title,
        actions: const [],
      ),
      body: this,
    );
  }
}
