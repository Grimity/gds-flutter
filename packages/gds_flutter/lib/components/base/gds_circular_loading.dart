import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/id_color_mapper.dart';

/// 디자인 시스템에서 사용하는 회전형 로딩 인디케이터 위젯.
class GdsCircularLoading extends StatefulWidget {
  const new({
    super.key,
    this.size = 24,
    this.duration = const Duration(seconds: 1),
  });

  /// 인디케이터의 가로 및 세로 크기.
  final double size;

  /// 인디케이터가 한 바퀴를 도는 데 걸리는 시간.
  final Duration duration;

  @override
  State<GdsCircularLoading> createState() => _GdsCircularLoadingState();
}

class _GdsCircularLoadingState extends State<GdsCircularLoading> with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(vsync: this, duration: widget.duration);

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
  void didUpdateWidget(covariant GdsCircularLoading oldWidget) {
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
        return Transform.rotate(
          angle: _animation.value * 2 * pi,
          child: child,
        );
      },
      child: SvgPicture.asset(
        'assets/vectors/component/circular_loading.svg',
        package: 'gds_flutter',
        width: widget.size,
        height: widget.size,
        colorMapper: IdColorMapper({
          'p1': GdsColor.iconGraySubtle.of(context),
        }),
      ),
    );
  }
}
