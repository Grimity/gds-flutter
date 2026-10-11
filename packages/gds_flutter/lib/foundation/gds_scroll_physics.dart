import 'dart:math';

import 'package:flutter/widgets.dart';

/// Android에서 플링 초기 속도를 낮추고 감속을 완만하게 조정하는 스크롤 물리.
class GdsScrollPhysics extends ClampingScrollPhysics {
  const new({super.parent});

  @override
  GdsScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return GdsScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = toleranceFor(position);
    if (position.outOfRange) {
      double? end;
      if (position.pixels > position.maxScrollExtent) {
        end = position.maxScrollExtent;
      }
      if (position.pixels < position.minScrollExtent) {
        end = position.minScrollExtent;
      }
      assert(end != null);
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        end!,
        min(0.0, velocity),
        tolerance: tolerance,
      );
    }
    if (velocity.abs() < tolerance.velocity) {
      return null;
    }
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
      return null;
    }
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
      return null;
    }

    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity * 0.75,
      friction: 0.006,
      tolerance: tolerance,
    );
  }
}
