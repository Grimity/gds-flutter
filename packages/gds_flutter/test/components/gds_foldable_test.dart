import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

void main() {
  testWidgets('GdsFoldable 위젯이 정상적으로 동작되는지 확인', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final width = 40.0;
    final height = 20.0;
    final animation = GdsFoldable.defaultAnimation;
    final duration = animation.duration;

    tester.view.physicalSize = Size(width, height);
    tester.view.devicePixelRatio = 1.0;

    Widget buildWidget(Key key, Axis axis, bool visible) {
      return Directionality(
        textDirection: .ltr,
        child: Center(
          child: GdsFoldable.builder(
            key: key,
            alignment: .center,
            animation: animation,
            visible: visible,
            axis: axis,
            builder: (_) => SizedBox(width: width, height: height),
          ),
        ),
      );
    }

    for (final axis in Axis.values) {
      final key = ValueKey(axis);
      final finder = find.byKey(key);
      final originAxisSize = axis == .vertical ? height : width;

      // 확장, 축소에 대한 대상 축의 현재 크기를 반환합니다.
      double getAxisSize() {
        return axis == .vertical ? tester.getSize(finder).height : tester.getSize(finder).width;
      }

      // 현재 적용된 투명도를 반환합니다.
      double getOpacity() {
        return tester.widget<Opacity>(find.byType(Opacity)).opacity;
      }

      // 초기에 접힌 상태로 시작하여 크기를 차지하지 않는지 확인.
      await tester.pumpWidget(buildWidget(key, axis, false));

      expect(getAxisSize(), isZero);
      expect(getOpacity(), isZero);

      // 확장시키고 절반 시점에서 본래 크기인지 확인.
      await tester.pumpWidget(buildWidget(key, axis, true));
      await tester.pump(duration ~/ 2);

      expect(getAxisSize(), originAxisSize);
      expect(getOpacity(), isZero);

      // 최종 시점에서 화면에 표시까지 되었는지 확인.
      await tester.pump(duration ~/ 2);

      expect(getAxisSize(), originAxisSize);
      expect(getOpacity(), 1.0);

      // 다시 축소시키고 절반 시점에서 화면에 표시되지 않는지 확인.
      await tester.pumpWidget(buildWidget(key, axis, false));
      await tester.pump(duration ~/ 2);

      expect(getAxisSize(), originAxisSize);
      expect(getOpacity(), isZero);

      // 최종 시점에서 레이아웃까지 완전히 축소되었는지 확인.
      await tester.pump(duration ~/ 2);

      expect(getAxisSize(), isZero);
      expect(getOpacity(), isZero);
    }
  });
}
