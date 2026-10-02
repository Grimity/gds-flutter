import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 탭에 표시할 라벨과 숫자 정보를 정의하는 인터페이스.
class GdsTabItem {
  const GdsTabItem({
    required this.label,
    this.count,
  });

  final String label;
  final int? count;
}

/// 라벨과 숫자로 구성된 가로 스크롤 탭 바 위젯.
@GdsSupportedSizes([.lg, .md, .sm])
class GdsTabBar extends StatelessWidget {
  const GdsTabBar({
    super.key,
    this.size,
    required this.items,
    required this.controller,
  });

  final GdsSize? size;
  final List<GdsTabItem> items;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final dividerColor = GdsColor.borderGraySubtle.of(context);
    final indicatorColor = GdsColor.borderGrayBold.of(context);

    // 크기를 지정하지 않은 경우, 현재 기기에 맞는 기본 크기를 적용.
    final GdsSize sizeByDevice = context.whenDevice(mobile: .sm, tablet: .md);
    final GdsSize size = this.size ?? sizeByDevice;

    return GdsMasking(
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: .start,
        dividerColor: dividerColor,
        indicatorSize: .tab,
        indicator: BoxDecoration(
          border: Border(bottom: .new(color: indicatorColor, width: 2)),
        ),
        enableFeedback: false,
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        tabs: items.indexedBuilder((index, item) => buildTab(size, index, item)),
      ),
    );
  }

  /// 각각의 탭 아이템 위젯.
  Widget buildTab(GdsSize size, int index, GdsTabItem item) {
    final GdsTypography typography = size.when(
      lg: .subtitle1,
      md: .label1,
      sm: .label3,
    );

    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final selected = controller.index == index;

        return GdsGesture(
          onTap: () => controller.animateTo(index),
          child: Padding(
            padding: .only(top: 12, bottom: 16),
            child: Row(
              mainAxisSize: .min,
              spacing: size.when(lg: 6, md: 6, sm: 4),
              children: [
                // 라벨 표시
                GdsText(
                  item.label,
                  color: selected ? .textGrayBold : .textGraySubtle,
                  style: typography,
                ),

                // 숫자 표시
                if (item.count != null) ...[
                  GdsText(
                    item.count.toString(),
                    color: selected ? .textPrimaryNormal : .textGraySubtle,
                    style: typography,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
