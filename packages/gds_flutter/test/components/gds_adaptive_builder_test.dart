import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

void main() {
  for (final width in [400.0, 800.0]) {
    for (final type in ['menu', 'modal', 'select']) {
      testWidgets('$type 너비 $width에서 builder 상태 갱신 및 결과 반환', (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(width, 900);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        final label = ValueNotifier('선택 전');
        addTearDown(label.dispose);
        final layerLink = LayerLink();

        await tester.pumpWidget(
          GdsApp(
            themeMode: .light,
            initialPage: GdsScaffold(
              body: Center(
                child: GdsPopoverAnchor(layerLink: layerLink, child: const SizedBox(width: 80, height: 40)),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 열린 화면 내부에서 상태를 구독하고, 내부 context로 결과 반환.
        List<GdsMenuItem> items(BuildContext context) {
          context.watch(label);
          return [(label: label.value, onTap: () => context.pop('완료'))];
        }

        final context = tester.element(find.byType(GdsScaffold));
        final result = switch (type) {
          'menu' => GdsAdaptiveMenu.show<String>(
            context,
            layerLink: layerLink,
            position: .left,
            builder: (context) => GdsAdaptiveMenu(items: items(context)),
          ),
          'select' => GdsAdaptiveSelect.show<String>(
            context,
            layerLink: layerLink,
            position: .left,
            builder: (context) => GdsAdaptiveSelect(title: '선택', index: 0, items: items(context)),
          ),
          _ => GdsAdaptiveModal.show<String>(
            context,
            builder: (context) {
              context.watch(label);
              return GdsAdaptiveModal(
                title: '모달',
                primaryButton: .new(label: label.value, onTap: () => context.pop('완료')),
                children: const [SizedBox(height: 40)],
              );
            },
          ),
        };
        await tester.pumpAndSettle();
        expect(find.text('선택 전', findRichText: true), findsOneWidget);

        // 다시 열지 않고 메뉴 항목 또는 버튼이 갱신되는지 확인.
        label.value = '선택 후';
        await tester.pumpAndSettle();
        expect(find.text('선택 후', findRichText: true), findsOneWidget);
        await tester.tap(find.text('선택 후', findRichText: true));
        await tester.pumpAndSettle();
        expect(await result, '완료');
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox());
      });
    }
  }
}
