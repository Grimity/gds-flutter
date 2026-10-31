// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 아이콘과 라벨로 구성된 탭 목록을 표시하는 하단 내비게이션 위젯.
class GdsBottomNavigation extends StatelessWidget {
  const new({
    super.key,
    required this.index,
    required this.tabs,
  });

  final int index;
  final List<GdsBottomNavigationTab> tabs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        // 상단에 보더 표시
        GdsDivider(variant: .secondary),

        // 탭 목록 표시
        GdsContainer(
          padding: .symmetric(vertical: 4),
          child: Row(children: tabs.builder(buildTab)),
        ),
      ],
    );
  }

  /// 각각의 하단 내비게이션 탭 위젯.
  Widget buildTab(GdsBottomNavigationTab tab) {
    final selected = index == tabs.indexOf(tab);

    return Expanded(
      child: tab.build(selected),
    );
  }
}
