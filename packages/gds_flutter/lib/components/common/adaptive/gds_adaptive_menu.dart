// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 탭하면 모바일에서는 바텀 시트, 태블릿에서는 팝오버로 액션 목록을 표시하는 위젯.
class GdsAdaptiveMenu {
  const new({
    required this.items,
  });

  final List<GdsMenuItem> items;

  /// 현재 기기에 맞는 표시 방식으로 액션 목록을 엽니다.
  static Future<T?> show<T>(
    BuildContext context, {
    required LayerLink layerLink,
    required GdsMenuPosition position,
    required GdsAdaptiveMenu Function(BuildContext context) builder,
  }) {
    if (context.isMobile) {
      // 모바일에서는 액션 목록을 바텀 시트로 표시.
      return GdsBottomSheet.show<T>(
        context,
        builder: (context) {
          final menu = builder(context);

          return GdsBottomSheet(
            onBack: context.pop,
            child: Column(
              mainAxisSize: .min,
              children: menu.items.builder((item) {
                return GdsListItem.text(
                  size: .lg,
                  label: item.label,
                  onTap: item.onTap,
                );
              }),
            ),
          );
        },
      );
    }

    // 태블릿에서는 팝오버 메뉴 표시.
    return GdsMenu.show<T>(
      context,
      layerLink: layerLink,
      position: position,
      builder: (context) => GdsMenu(items: builder(context).items),
    );
  }
}
