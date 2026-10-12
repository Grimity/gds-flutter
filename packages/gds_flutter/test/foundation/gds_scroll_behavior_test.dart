import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

void main() {
  testWidgets('reduces Android fling velocity while retaining the iOS tracker', (tester) async {
    const behavior = GdsScrollBehavior();
    late BuildContext testContext;

    Future<void> show(TargetPlatform platform) async {
      await tester.pumpWidget(
        Theme(
          data: ThemeData(platform: platform),
          child: Builder(
            builder: (context) {
              testContext = context;
              return const SizedBox();
            },
          ),
        ),
      );
    }

    await show(TargetPlatform.android);
    final tracker = behavior.velocityTrackerBuilder(testContext)(
      const PointerDownEvent(kind: PointerDeviceKind.touch),
    );
    final original = VelocityTracker.withKind(PointerDeviceKind.touch);
    for (var i = 0; i < 6; i++) {
      final time = Duration(milliseconds: i * 10);
      final position = Offset(i * 10.0, i * 20.0);
      tracker.addPosition(time, position);
      original.addPosition(time, position);
    }

    final velocity = tracker.getVelocityEstimate()!.pixelsPerSecond;
    final expected = original.getVelocityEstimate()!.pixelsPerSecond * 0.75;
    expect(velocity.dx, closeTo(expected.dx, 0.001));
    expect(velocity.dy, closeTo(expected.dy, 0.001));

    await show(TargetPlatform.iOS);
    expect(
      behavior.velocityTrackerBuilder(testContext)(const PointerDownEvent()),
      isA<IOSScrollViewFlingVelocityTracker>(),
    );
  });

  test('preserves current velocity when recreating the scroll simulation', () {
    final metrics = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 10000,
      pixels: 100,
      viewportDimension: 400,
      axisDirection: AxisDirection.right,
      devicePixelRatio: 1,
    );
    const physics = GdsScrollPhysics();
    final simulation = physics.createBallisticSimulation(metrics, 1000)!;
    final velocity = simulation.dx(0.1);
    final restarted = physics.createBallisticSimulation(metrics, velocity)!;

    expect(restarted.dx(0), closeTo(velocity, 0.001));
  });
}
