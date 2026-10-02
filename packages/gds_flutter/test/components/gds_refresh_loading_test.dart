import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

import '../test.dart';

void main() {
  testWidgets('GdsRefreshLoading 컴포넌트가 정상적으로 동작되는지 확인', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final dimension = 24.0;
    tester.view.physicalSize = Size.square(dimension);
    tester.view.devicePixelRatio = 1.0;

    for (final theme in testThemes) {
      await tester.pumpWidget(
        TestApp(
          theme: theme,
          body: GdsRefreshLoading(
            size: dimension,
            duration: const Duration(seconds: 1),
          ),
        ),
      );

      final steps = 8; // 1초를 8등분 (125ms 간격)
      final stepDuration = Duration(milliseconds: 1000 ~/ steps);

      for (int i = 0; i < steps; i++) {
        await expectLater(
          find.byType(TestApp),
          matchesGoldenFile('goldens/gds_refresh_loading/${theme.name}/${i + 1}.png'),
        );

        // 마지막 프레임이 아닐 때만 다음 프레임으로 진행.
        if (i < steps) {
          await tester.pump(stepDuration);
        }
      }
    }
  });
}
