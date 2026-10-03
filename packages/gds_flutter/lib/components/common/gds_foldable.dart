import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 표시 여부에 따라 자식의 크기를 접고 펼치는 애니메이션 위젯.
class GdsFoldable extends StatefulWidget {
  const new builder({
    super.key,
    required this.alignment,
    this.animation = defaultAnimation,
    required this.visible,
    required this.axis,
    required this.builder,
  });

  final Alignment alignment;
  final GdsAnimation animation;
  final bool visible;
  final Axis axis;
  final WidgetBuilder builder;

  static const GdsAnimation defaultAnimation = .slowest;

  @override
  State<GdsFoldable> createState() => _GdsFoldableState();
}

class _GdsFoldableState extends State<GdsFoldable> with TickerProviderStateMixin {
  late final AnimationController _animation;

  late final CurvedAnimation _curvedOpacity;
  late final CurvedAnimation _curvedSize;

  // 애니메이션 도중 재빌드를 방지하기 위한 캐싱되는 위젯.
  Widget? _cachedChild;

  @override
  void initState() {
    super.initState();

    final initialValue = widget.visible ? 1.0 : 0.0;
    final curve = widget.animation.curve;

    _animation = .new(
      vsync: this,
      value: initialValue,
      duration: widget.animation.duration,
    );

    _curvedSize = .new(
      parent: _animation,
      curve: Interval(0.0, 0.5, curve: curve),
      reverseCurve: Interval(0.0, 0.5, curve: curve.flipped),
    );

    _curvedOpacity = .new(
      parent: _animation,
      curve: Interval(0.5, 1.0, curve: curve),
      reverseCurve: Interval(0.5, 1.0, curve: curve.flipped),
    );
  }

  @override
  void didUpdateWidget(covariant GdsFoldable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // visible 속성이 변경되었을 경우.
    if (widget.visible != oldWidget.visible) {
      widget.visible ? _animation.forward() : _animation.reverse();
    }

    // animation 속성이 변경되었을 경우.
    if (widget.animation != oldWidget.animation) {
      _animation.duration = widget.animation.duration;
      _curvedSize.curve = Interval(0.0, 0.5, curve: widget.animation.curve);
      _curvedOpacity.curve = Interval(0.5, 1.0, curve: widget.animation.curve);
    }
  }

  @override
  void dispose() {
    _curvedOpacity.dispose();
    _curvedSize.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 자식이 표시된 동안에만 변경 사항을 캐시에 반영.
    if (widget.visible) {
      _cachedChild = widget.builder(context);
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final opacity = _curvedOpacity.value;
        final size = _curvedSize.value;

        return Align(
          widthFactor: widget.axis == .horizontal ? size : 1,
          heightFactor: widget.axis == .vertical ? size : 1,
          alignment: widget.alignment,
          child: Opacity(
            opacity: opacity,
            child: size == 0 ? null : _cachedChild,
          ),
        );
      },
    );
  }
}
