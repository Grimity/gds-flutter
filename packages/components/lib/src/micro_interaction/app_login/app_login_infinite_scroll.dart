import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gds_foundation/gds_foundation.dart';

class AppLoginInfiniteScroll extends StatefulWidget {
  const AppLoginInfiniteScroll({
    super.key,
    required this.images,
    required this.velocity,
    required this.spacing,
    this.reverse = false,
  }) : assert(velocity > 0);

  final List<GdsImage> images;
  final double velocity;
  final double spacing;
  final bool reverse;

  @override
  State<AppLoginInfiniteScroll> createState() => _AppLoginInfiniteScrollState();
}

class _AppLoginInfiniteScrollState extends State<AppLoginInfiniteScroll> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Ticker _ticker;

  // 현재 스크롤 위치를 추적하기 위한 변수
  double _currentOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _ticker = createTicker((elapsed) {
      if (!_scrollController.hasClients) return;

      // 스크롤 컨트롤러의 현재 위치와 최대 범위를 확인하여 스크롤이 가능한지 여부를 판단
      final position = _scrollController.position;
      if (!position.hasContentDimensions) return;

      // velocity에 따라 스크롤 위치 업데이트
      double delta = widget.velocity / 60;
      _currentOffset += delta;

      // 스크롤이 최대 범위를 초과하면 다시 시작점으로 돌아가도록 설정
      _scrollController.jumpTo(_currentOffset);
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: ListView.builder(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        reverse: widget.reverse,
        itemBuilder: (context, index) {
          final actualIndex = index % widget.images.length;

          return Padding(
            padding: EdgeInsets.only(bottom: widget.spacing),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(GdsRadius.md),
              child: widget.images[actualIndex].build(fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
