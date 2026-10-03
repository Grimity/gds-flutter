import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 탭 목록과 선택한 탭의 콘텐츠를 함께 표시하는 위젯.
@GdsSupportedSizes([.lg, .md, .sm])
class GdsTab extends StatefulWidget {
  const new({
    super.key,
    this.size,
    this.initialIndex = 0,
    required this.items,
    required this.pages,
  });

  final GdsSize? size;
  final int initialIndex;
  final List<GdsTabItem> items;
  final List<Widget> pages;

  @override
  State<GdsTab> createState() => _GdsTabState();
}

class _GdsTabState extends State<GdsTab> with TickerProviderStateMixin {
  late TabController controller = .new(
    initialIndex: widget.initialIndex,
    length: length,
    vsync: this,
  );

  /// 현재 탭 아이템의 개수를 반환합니다.
  int get length => widget.items.length;

  @override
  void didUpdateWidget(covariant GdsTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldLength = oldWidget.items.length;
    final newLength = length;

    // 탭 수가 변경되면 길이에 맞는 컨트롤러로 갱신.
    if (oldLength != newLength) {
      setState(() => controller = .new(length: length, vsync: this));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 탭바 표시
        GdsTabBar(
          size: widget.size,
          items: widget.items,
          controller: controller,
        ),

        // 탭뷰 표시
        if (widget.pages.isNotEmpty) ...[
          Expanded(
            child: TabBarView(
              controller: controller,
              children: widget.pages,
            ),
          ),
        ],
      ],
    );
  }
}
