import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/id_color_mapper.dart';

/// 디자인 시스템에서 사용하는 페이지 로딩 인디케이터 위젯.
class GdsRefreshLoading extends StatefulWidget {
  const GdsRefreshLoading({
    super.key,
    this.size = 24,
    this.duration = const Duration(seconds: 1),
  });

  /// 인디케이터의 가로 및 세로 크기.
  final double size;

  /// 인디케이터가 한 바퀴를 도는 데 걸리는 시간.
  final Duration duration;

  @override
  State<GdsRefreshLoading> createState() => _GdsRefreshLoadingState();
}

class _GdsRefreshLoadingState extends State<GdsRefreshLoading> with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(vsync: this, duration: widget.duration);

  /// 인디케이터의 각 파트에 대한 색상 배열.
  static const _colors = <GdsColor>[
    .refreshLoading1,
    .refreshLoading2,
    .refreshLoading3,
    .refreshLoading4,
    .refreshLoading5,
    .refreshLoading6,
    .refreshLoading7,
    .refreshLoading8,
  ];

  @override
  void initState() {
    super.initState();
    _animation.repeat();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant GdsRefreshLoading oldWidget) {
    super.didUpdateWidget(oldWidget);

    // duration 속성이 변경되었을 경우.
    if (oldWidget.duration != widget.duration) {
      _animation.duration = widget.duration;
      _animation.reset();
      _animation.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _animation,
      builder: (context, child) {
        final offset = _animation.value * _colors.length;

        // 인디케이터의 각 파트에 대한 색상을 반환합니다.
        Color colorAt(int index) {
          final colorIndex = (index - offset) % _colors.length;
          final startIndex = colorIndex.floor();
          final endIndex = (startIndex + 1) % _colors.length;

          return Color.lerp(
            _colors[startIndex].of(context),
            _colors[endIndex].of(context),
            colorIndex - startIndex,
          )!;
        }

        return SvgPicture.asset(
          'assets/vectors/component/refresh_loading.svg',
          package: 'gds_flutter',
          width: widget.size,
          height: widget.size,
          colorMapper: IdColorMapper({
            'p1': colorAt(0),
            'p2': colorAt(1),
            'p3': colorAt(2),
            'p4': colorAt(3),
            'p5': colorAt(4),
            'p6': colorAt(5),
            'p7': colorAt(6),
            'p8': colorAt(7),
          }),
        );
      },
    );
  }
}
