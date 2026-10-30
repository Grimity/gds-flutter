import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 각각의 선택 메뉴 항목의 라벨과 콜백을 정의하는 레코드.
typedef GdsSelectItem = ({
  String label,
  VoidCallback onTap,
});

/// 모바일에서는 바텀 시트, 태블릿에서는 팝오버로 선택 항목을 표시하는 위젯.
class GdsAdaptiveSelect extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.index,
    required this.items,
  });

  final String title;
  final int index;
  final List<GdsSelectItem> items;

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
  static Future<T?> show<T>(
    BuildContext context, {
    required LayerLink layerLink,
    required GdsMenuPosition position,
    required GdsAdaptiveSelect Function(BuildContext context) builder,
  }) {
    if (context.isMobile) {
      // 모바일에서는 선택 목록을 바텀 시트로 표시.
      return GdsBottomSheet.show<T>(
        context,
        builder: (context) {
          final select = builder(context);

          return GdsBottomSheet(
            onBack: context.pop,
            title: select.title,
            child: select,
          );
        },
      );
    }

    // 태블릿에서는 팝오버 메뉴 표시.
    return GdsMenu.show<T>(
      context,
      layerLink: layerLink,
      position: position,
      builder: (context) {
        final widget = builder(context);

        return GdsMenu(
          items: widget.items.indexedBuilder((index, item) {
            return .new(
              label: item.label,
              onTap: item.onTap,
              status: .from(selected: widget.index == index),
            );
          }),
        );
      },
    );
  }
}
