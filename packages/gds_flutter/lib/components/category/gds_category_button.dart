import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 카테고리 항목을 선택할 수 있는 버튼 위젯.
@GdsSupportedSizes([.lg, .md])
class GdsCategoryButton extends StatelessWidget {
  const new({
    super.key,
    required this.size,
    required this.item,
    required this.onTap,
    required this.selected,
  });

  final GdsSize size;
  final GdsCategoryItem item;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: onTap,
      child: GdsContainer(
        height: size.when(lg: 40, md: 32),
        radius: .full,
        border: selected ? null : .all(color: .borderGraySubtle),
        color: selected ? .surfacePrimaryNormal : null,
        padding: .symmetric(
          horizontal: size.when(lg: 16, md: 12),
        ),
        alignment: .center,
        child: Row(
          mainAxisSize: .min,
          spacing: 4,
          children: [
            // 라벨 표시
            GdsText(
              item.label,
              color: selected ? .textWhite : .textGrayBold,
              style: size.when(lg: .label1, md: .label3),
            ),

            // 숫자 표시
            GdsText(
              item.count.toString(),
              color: selected ? .textWhite : .textGrayBold,
              style: size.when(lg: .label1, md: .label3),
            ),
          ],
        ),
      ),
    );
  }
}
