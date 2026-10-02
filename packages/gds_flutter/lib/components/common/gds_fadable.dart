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

class _GdsFadableState extends State<GdsFadable> {
  // 애니메이션 도중 재빌드를 방지하기 위한 캐싱되는 위젯.
  Widget? _cachedChild;

  @override
  Widget build(BuildContext context) {
    // 자식이 표시된 동안에만 변경 사항을 캐시에 반영.
    if (widget.visible) {
      _cachedChild = widget.builder(context);
    }

    return GdsTransition.builder(
      value: widget.visible ? 1.0 : 0.0,
      child: _cachedChild,
      builder: (context, value, child) {
        // 애니메이션 값이 오차 범위보다 작으면 자식을 빌드하지 않음.
        if (child == null || value < precisionErrorTolerance) {
          return SizedBox.shrink();
        }

        return widget.type.build(child, value);
      },
    );
  }
}
