import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 카테고리 목록과 우측에 액션 버튼을 표시하는 위젯.
@GdsSupportedSizes([.lg, .md])
class GdsCategory extends StatelessWidget {
  const GdsCategory({
    super.key,
    this.size,
    required this.index,
    required this.items,
    required this.onChanged,
    this.action,
  });

  final GdsSize? size;
  final int index;
  final List<GdsCategoryItem> items;
  final ValueChanged<int> onChanged;

  /// 카테고리 목록 우측에 표시할 액션 버튼.
  final GdsIconButtonAction? action;

  @override
  Widget build(BuildContext context) {
    final hasAction = action != null;

    // 크기를 지정하지 않은 경우, 현재 기기에 맞는 기본 크기를 적용.
    final GdsSize size = this.size ?? .md;

    return Row(
      children: [
        // 좌측에 카테고리 스크롤 목록 표시
        Expanded(
          child: GdsMasking(
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              clipBehavior: .none,
              child: Row(
                spacing: size.when(lg: 8, md: 6),
                children: items.indexedBuilder((index, item) {
                  return buildButton(size, index, item);
                }),
              ),
            ),
          ),
        ),

        // 우측에 액션 버튼 표시
        GdsFoldable.builder(
          alignment: .centerLeft,
          visible: hasAction,
          axis: .horizontal,
          builder: (context) {
            return Padding(
              padding: .only(left: size.when(lg: 16, md: 12)),
              child: GdsButton.icon(
                type: .outlined,
                icon: action!.icon,
                onTap: action!.onTap,
              ),
            );
          },
        ),
      ],
    );
  }

  /// 각 카테고리 항목 버튼 위젯.
  Widget buildButton(GdsSize size, int index, GdsCategoryItem item) {
    final selected = this.index == index;

    return GdsCategoryButton(
      size: size,
      item: item,
      onTap: () => onChanged(index),
      selected: selected,
    );
  }
}
