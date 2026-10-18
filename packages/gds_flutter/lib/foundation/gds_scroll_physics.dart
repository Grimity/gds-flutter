import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Android의 스크롤 경계 처리를 유지하면서 감속을 완만하게 조정하는 스크롤 물리.
class GdsScrollPhysics extends ClampingScrollPhysics {
  const new({super.parent});

  @override
  GdsScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return .new(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = toleranceFor(position);

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
      velocity: velocity,
      friction: 0.006,
      tolerance: tolerance,
    );
  }
}

/// 최초 플링의 추정 속도를 낮추는 Android 전용 속도 트래커.
class GdsVelocityTracker extends VelocityTracker {
  new(super.kind) : super.withKind();

  @override
  VelocityEstimate? getVelocityEstimate() {
    final estimate = super.getVelocityEstimate();
    if (estimate == null) return null;

    return .new(
      pixelsPerSecond: estimate.pixelsPerSecond * 0.75,
      confidence: estimate.confidence,
      duration: estimate.duration,
      offset: estimate.offset,
    );
  }
}
