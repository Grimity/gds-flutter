import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

import '../test.dart';

void main() {
  testWidgets('GdsDivider 컴포넌트가 정상적으로 동작되는지 확인', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    const margin = EdgeInsets.all(12);
    final maxHeight = 40.0;

    tester.view.physicalSize = Size(256, 256);
    tester.view.devicePixelRatio = 1.0;

    for (final theme in testThemes) {
      for (final variant in GdsDividerVariant.values) {
        final key = Key(variant.name);

        await tester.pumpWidget(
          TestApp(
            key: key,
            theme: theme,
            body: Column(
              mainAxisAlignment: .center,
              spacing: 20,
              children: [
                GdsDivider(variant: variant),
                GdsDivider(variant: variant, bold: true),
                GdsDivider(variant: variant, margin: margin),
                SizedBox(
                  height: maxHeight,
                  child: GdsDivider(variant: variant, vertical: true),
                ),
              ],
            ),
          ),
        );

        // Secondary 유형에 대한 골든 테스트
        await expectLater(
          find.byKey(key),
          matchesGoldenFile('goldens/gds_divider/${theme.name}/${variant.name}.png'),
        );
      }
    }
  });
}
