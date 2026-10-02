import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

import '../test.dart';

void main() {
  testWidgets('모든 아이콘이 정상적으로 렌더링 되는지 확인', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    tester.view.physicalSize = const Size(32, 32);
    tester.view.devicePixelRatio = 1.0;

    for (final theme in testThemes) {
      for (final icon in GdsIcon.values) {
        final key = ValueKey(icon.name);

        await tester.pumpWidget(
          TestApp(
            key: key,
            theme: theme,
            body: switch (icon.type) {
              .fixed => icon.build(size: 32),
              .themed => icon.build(size: 32),
              .semantic => icon.build(size: 32, color: .iconGrayBold),
            },
          ),
        );

        await tester.pumpAndSettle();

        await expectLater(
          find.byKey(key),
          matchesGoldenFile('goldens/gds_icon/${theme.name}/${icon.name}.png'),
        );
      }
    }
  });
}
