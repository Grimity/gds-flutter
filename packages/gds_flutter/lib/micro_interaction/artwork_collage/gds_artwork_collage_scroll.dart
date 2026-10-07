import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsArtworkCollage]에서 이미지 목록을 반복하여 세로로 자동 스크롤하는 위젯.
class GdsArtworkCollageScroll extends StatefulWidget {
  const new({
    super.key,
    required this.images,
    required this.velocity,
    required this.spacing,
    this.reverse = false,
  }) : assert(velocity > 0);

  final List<ImageProvider> images;
  final double velocity;
  final double spacing;
  final bool reverse;

  @override
  State<GdsArtworkCollageScroll> createState() => _State();
}

class _State extends State<GdsArtworkCollageScroll> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Ticker _ticker;

  // 현재 스크롤 위치를 추적하기 위한 값.
  double _currentOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _ticker = createTicker((elapsed) {
      if (!_scrollController.hasClients) return;

      // 스크롤이 가능한지 여부.
      final position = _scrollController.position;
      if (!position.hasContentDimensions) return;

      // 초당 60프레임을 기준으로 매 프레임 이동할 거리를 누적.
      final delta = widget.velocity / 60;
      _currentOffset += delta;

      // 스크롤이 최대 범위를 초과하면 다시 시작점으로 돌아가도록 함.
      _scrollController.jumpTo(_currentOffset);
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: .new().copyWith(scrollbars: false),
      child: ListView.builder(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        reverse: widget.reverse,
        itemBuilder: (context, index) {
          // 이미지 목록의 끝에 도달하면 첫 이미지부터 다시 표시.
          final actualIndex = index % widget.images.length;

          return Padding(
            padding: .only(bottom: widget.spacing),
            child: GdsThumbnail(
              ratio: .portrait,
              radius: .md,
              provider: widget.images[actualIndex],
            ),
          );
        },
      ),
    );
  }
}
