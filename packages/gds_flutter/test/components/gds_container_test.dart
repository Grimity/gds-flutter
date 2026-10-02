import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

import '../test.dart';

void main() {
  testWidgets('테마 색상과 투명도가 올바르게 적용되는지 확인', (tester) async {
    const GdsColor color = .surfacePrimaryNormal;
    const GdsOpacity opacity = .opacity60;

    for (final theme in testThemes) {
      await tester.pumpWidget(
        TestApp(
          theme: theme,
          body: GdsContainer(
            width: 40,
            height: 40,
            color: color,
            opacity: opacity,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 내부 컨테이너에 적용된 BoxDecoration 조회.
      final animatedContainers = tester.widgetList<AnimatedContainer>(
        find.descendant(
          of: find.byType(GdsContainer),
          matching: find.byType(AnimatedContainer),
        ),
      );

      final decoration = animatedContainers
          .map((container) => container.decoration)
          .whereType<BoxDecoration>()
          .singleWhere((decoration) => decoration.color != null);

      final resolvedColor = theme.semantic.fromEnum(color);

      // 현재 테마의 실제 색상과 투명도가 적용됐는지 확인.
      expect(decoration.color, resolvedColor.withAlpha(opacity.alpha));
    }
  });

  testWidgets('테두리에 상관없이 크기가 계산되는지 확인', (tester) async {
    final dimension = 40.0;
    final border1 = GdsBorder.all(color: .borderGraySubtler, width: 1);
    final border2 = GdsBorder.all(color: .borderGraySubtler, width: 2);

    // 테두리가 없거나 서로 다른 두께를 가진 동일 크기의 컨테이너 렌더링.
    await tester.pumpWidget(
      TestApp(
        theme: .light(),
        body: Stack(
          children: [
            GdsContainer(width: dimension, height: dimension),
            GdsContainer(width: dimension, height: dimension, border: border1),
            GdsContainer(width: dimension, height: dimension, border: border2),
          ],
        ),
      ),
    );

    // 렌더링된 각 컨테이너의 실제 크기 조회.
    final finder = find.byType(GdsContainer);
    final sizes = finder.evaluate().map((e) => e.size);

    // 테두리 두께와 상관없이 모든 컨테이너의 크기가 동일한지 확인.
    expect(sizes.toSet().length, 1);
  });

  group('크기에 대한 제약 조건이 올바르게 적용되는지 확인', () {
    const constraints = BoxConstraints(
      minWidth: 40.0,
      minHeight: 25.0,
      maxWidth: 100.0,
      maxHeight: 50.0,
    );

    final finder = find.byType(GdsContainer);

    Widget build(Widget child) {
      return TestApp(
        body: Align(
          child: GdsContainer(
            minWidth: constraints.minWidth,
            minHeight: constraints.minHeight,
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
            child: child,
          ),
        ),
      );
    }

    testWidgets('최소 크기가 올바르게 적용되는지 확인', (tester) async {
      // 자식을 최소 크기보다 더 작게.
      await tester.pumpWidget(build(SizedBox(width: 30, height: 20)));

      expect(tester.getSize(finder), constraints.smallest);
    });

    testWidgets('최대 크기가 올바르게 적용되는지 확인', (tester) async {
      // 자식을 최대 크기보다 더 크게.
      await tester.pumpWidget(build(SizedBox(width: 120, height: 60)));

      expect(tester.getSize(finder), constraints.biggest);
    });
  });
}
