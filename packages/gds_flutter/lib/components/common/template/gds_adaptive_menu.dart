import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 탭하면 모바일에서는 바텀 시트, 태블릿에서는 팝오버로 액션 목록을 표시하는 위젯.
class GdsAdaptiveMenu {
  const new({
    required this.layerLink,
    required this.position,
    required this.items,
  });

  final LayerLink layerLink;
  final GdsMenuPosition position;
  final List<GdsMenuItem> items;

  /// 현재 기기에 맞는 표시 방식으로 액션 목록을 엽니다.
  Future<T?> open<T>(BuildContext context) {
    if (context.isMobile) {
      // 모바일에서는 액션 목록을 바텀 시트로 표시.
      final bottomSheet = GdsBottomSheet(
        onBack: context.pop,
        child: Column(
          mainAxisSize: .min,
          children: items.builder((item) {
            return GdsListItem.text(
              size: .lg,
              label: item.label,
              onTap: item.onTap,
            );
          }),
        ),
      );

      return bottomSheet.open(context);
    }

    final menu = GdsMenu(items: items);

    // 태블릿에서는 팝오버 메뉴 표시.
    return menu.open(
      context,
      layerLink: layerLink,
      position: position,
    );
  }
}
