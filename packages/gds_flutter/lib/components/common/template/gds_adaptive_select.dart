import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 모바일에서는 바텀 시트, 태블릿에서는 팝오버로 선택 항목을 표시하는 위젯.
class GdsAdaptiveSelect extends StatelessWidget {
  const new({
    super.key,
    required this.layerLink,
    required this.position,
    required this.title,
    required this.index,
    required this.items,
  });

  final LayerLink layerLink;
  final GdsMenuPosition position;
  final String title;
  final int index;
  final List<GdsMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      spacing: 8,
      children: items.indexedBuilder((index, item) {
        return GdsListItem.optionCard(
          label: item.label,
          onTap: item.onTap,
          status: .from(selected: this.index == index),
        );
      }),
    );
  }

  /// 현재 기기에 맞는 표시 방식으로 선택 목록을 엽니다.
  Future<T?> open<T>(BuildContext context) {
    if (context.isMobile) {
      // 모바일에서는 선택 목록을 바텀 시트로 표시.
      final bottomSheet = GdsBottomSheet(
        onBack: context.pop,
        title: title,
        child: this,
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
