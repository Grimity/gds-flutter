import 'package:flutter/material.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_components/src/gnb/overlay/gds_menu_route.dart';
import 'package:gds_foundation/gds_foundation.dart';

/// 메뉴가 기준 위젯에 맞춰 표시될 가로 위치입니다.
enum GdsMenuPosition {
  left,
  right,
  center,
}

/// [GdsMenu]에 표시할 메뉴 항목입니다.
class GdsMenuItem {
  const GdsMenuItem({
    required this.label,
    required this.onTap,
    this.state = GdsListItemState.enabled,
  });

  /// 메뉴 항목에 표시할 텍스트
  final String label;

  /// 메뉴 항목을 탭했을 때 호출되는 콜백
  final VoidCallback onTap;

  /// 메뉴 항목의 상태
  final GdsListItemState state;
}

/// 기준 위젯 아래에 표시되는 메뉴 컴포넌트입니다.
/// [items]는 그룹 단위로 전달하며, 그룹 사이에는 구분선이 표시됩니다.
///
/// ```dart
/// GdsMenuAnchor(
///   builder: (link) {
///     final menu = GdsMenu(items: ...);
///
///     menu.open(
///       context,
///       position: GdsMenuPosition.left,
///       layerLink: link,
///     );
///   }
/// );
/// ```
class GdsMenu extends StatelessWidget {
  const GdsMenu({
    super.key,
    this.width = 150,
    required this.items,
  });

  /// 메뉴의 가로 너비
  final double width;

  /// 메뉴 항목 그룹 목록
  final List<List<GdsMenuItem>> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing6),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colors.surface.base,
        boxShadow: GdsShadows.level2,
        borderRadius: BorderRadius.circular(GdsRadius.md),
        border: Border.all(
          color: colors.border.graySubtler,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: GdsSpacing.spacing8,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            ...items[i].map((item) {
              return GdsListItem.textMedium(
                text: item.label,
                onTap: item.onTap,
                state: item.state,
                isNegative: false,
              );
            }),

            if (i < items.length - 1) GdsDivider.secondary(),
          ],
        ],
      ),
    );
  }

  /// 오버레이에 메뉴를 화면에 표시합니다.
  Future<T?> open<T>(
    BuildContext context, {
    required LayerLink layerLink,
    required GdsMenuPosition position,
  }) {
    final route = GdsMenuRoute<T>(
      child: this,
      position: position,
      layerLink: layerLink,
    );

    return Navigator.push<T>(context, route);
  }
}
