import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

import '../test.dart';

void main() {
  testWidgets('GdsPushBadge.dot 컴포넌트가 정상적으로 동작되는지 확인', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final dimension = 24.0;
    final sizes = <GdsSize>[.xs, .sm, .md];

    tester.view.physicalSize = Size(dimension, dimension * sizes.length);
    tester.view.devicePixelRatio = 1.0;

    for (final theme in testThemes) {
      for (final position in GdsDotPushBadgePosition.values) {
        final key = Key(position.name);

        await tester.pumpWidget(
          TestApp(
            key: key,
            theme: theme,
            body: Column(
              children: [
                for (final size in sizes) ...[
                  GdsPushBadge.dot(
                    size: size,
                    position: position,
                    child: SizedBox.square(dimension: dimension),
                  ),
                ],
              ],
            ),
          ),
        );

        await expectLater(
          find.byKey(key),
          matchesGoldenFile('goldens/gds_push_badge/dot/${theme.name}/${position.name}.png'),
        );
      }
    }
  });
}
