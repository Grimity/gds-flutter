import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 자식의 표시와 숨김에 사용할 애니메이션 유형.
enum GdsFadableType {
  /// 투명도만 조절.
  fade,

  /// 크기만 조절.
  scaled,

  /// 크기와 투명도 조절.
  scaleFade;

  /// 현재 유형에 맞춰 주어진 위젯에 전환 효과를 적용합니다.
  Widget build(Widget child, double value) {
    return switch (this) {
      .fade => Opacity(opacity: value, child: child),
      .scaled => Transform.scale(scale: value, child: child),
      .scaleFade => Transform.scale(
        scale: value,
        child: Opacity(opacity: value, child: child),
      ),
    };
  }
}

/// 표시 여부에 따라 자식의 시각적 크기나 투명도를 조절하는 애니메이션 위젯.
class GdsFadable extends StatefulWidget {
  const GdsFadable.builder({
    super.key,
    required this.type,
    required this.visible,
    required this.builder,
    this.animation = .normal,
  });

  final GdsFadableType type;
  final bool visible;
  final WidgetBuilder builder;
  final GdsAnimation animation;

  @override
  State<GdsFadable> createState() => _GdsFadableState();
}

class _GdsFadableState extends State<GdsFadable> with TickerProviderStateMixin {
  late final AnimationController _animation;
  late final CurvedAnimation _curved;

  // 애니메이션 도중 재빌드를 방지하기 위한 캐싱되는 위젯.
  Widget? _cachedChild;

  @override
  void initState() {
    super.initState();

    final initialValue = widget.visible ? 1.0 : 0.0;
    final curve = widget.animation.curve;

    _animation = .new(vsync: this, duration: widget.animation.duration, value: initialValue);
    _curved = .new(parent: _animation, curve: curve, reverseCurve: curve.flipped);
  }

  @override
  void didUpdateWidget(covariant GdsFadable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // visible 속성이 변경되었을 경우.
    if (widget.visible != oldWidget.visible) {
      widget.visible ? _animation.forward() : _animation.reverse();
    }

    // animation 속성이 변경되었을 경우.
    if (widget.animation != oldWidget.animation) {
      _animation.duration = widget.animation.duration;
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    _curved.dispose();
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
        final value = _curved.value;
        final child = _cachedChild;

        // 애니메이션 값이 오차 범위보다 작으면 자식을 빌드하지 않음.
        if (child == null || value < precisionErrorTolerance) {
          return SizedBox.shrink();
        }

        return widget.type.build(child, value);
      },
    );
  }
}
