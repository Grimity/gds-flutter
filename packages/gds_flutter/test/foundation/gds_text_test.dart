import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

import '../test.dart';

void main() {
  testWidgets('모든 텍스트 스타일이 정상적으로 렌더링 되는지 확인', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    tester.view.physicalSize = const Size(512, 48);
    tester.view.devicePixelRatio = 1.0;

    for (final theme in testThemes) {
      for (final style in GdsTypography.values) {
        final key = ValueKey(style.name);

        await tester.pumpWidget(
          TestApp(
            key: key,
            theme: theme,
            body: GdsText(
              'Hello, World! 가나다라마바',
              color: .textGrayBold,
              style: style,
            ),
          ),
        );

        await tester.pumpAndSettle();

        await expectLater(
          find.byKey(key),
          matchesGoldenFile('goldens/gds_text/${theme.name}/${style.name}.png'),
        );
      }
    }
  });
}
