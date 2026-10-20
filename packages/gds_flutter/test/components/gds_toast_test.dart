import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

void main() {
  testWidgets('현재 화면에 GdsOverlay가 없으면 앱 내비게이터의 오버레이에 토스트 표시', (tester) async {
    // GdsOverlay가 없는 화면에 앱 내비게이터만 연결.
    await tester.pumpWidget(
      GdsThemeScope(
        theme: .light(),
        child: MaterialApp(
          navigatorKey: GdsApp.navigationKey,
          home: const SizedBox(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 앱 내비게이터의 내부 오버레이를 사용하여 토스트 표시.
    expect(GdsOverlay.current, same(GdsApp.navigationKey.currentState!.overlay));
    GdsToast.show('업로드 완료');
    await tester.pumpAndSettle();

    // 조상 Overlay 탐색 오류 없이 토스트가 표시되는지 확인.
    expect(tester.takeException(), isNull);
    expect(find.text('업로드 완료'), findsOneWidget);

    // 토스트의 타이머와 애니메이션 정리.
    await tester.pump(const Duration(seconds: 20));
    await tester.pumpAndSettle();
  });

  testWidgets('화면 교체 직후 토스트를 새 화면의 앱바 아래에 표시', (tester) async {
    // 앱바 높이를 다르게 지정할 수 있는 테스트 화면 구성.
    Widget page(String label, double appBarHeight) {
      return GdsScaffold(
        appBar: SizedBox(
          key: ValueKey('$label-appbar'),
          height: appBarHeight,
          child: GdsText(
            label,
            color: .textGrayBold,
            style: .label3,
          ),
        ),
        body: Center(
          child: GdsText(
            '$label-body',
            color: .textGrayBold,
            style: .label3,
          ),
        ),
      );
    }

    // 첫 화면을 표시하고 현재 오버레이 기록.
    await tester.pumpWidget(
      GdsThemeScope(
        theme: .light(),
        child: MaterialApp(home: page('first', 40)),
      ),
    );

    await tester.pumpAndSettle();

    final previousOverlay = GdsOverlay.current;
    final context = tester.element(find.text('first-body'));

    // 앱바가 더 높은 화면으로 교체하면서 토스트 표시 요청.
    Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute(builder: (_) => page('second', 80)),
    );

    GdsToast.show('업로드 완료');
    await tester.pumpAndSettle();

    // 토스트가 이전 화면이 아닌 새 화면의 오버레이에 표시되는지 확인.
    expect(find.text('업로드 완료'), findsOneWidget);
    expect(GdsOverlay.current, isNot(same(previousOverlay)));
    expect(Overlay.of(tester.element(find.byType(GdsToast))), same(GdsOverlay.current));

    // 새 화면의 앱바 하단보다 토스트가 아래에 배치되는지 확인.
    expect(
      tester.getTopLeft(find.byType(GdsToast)).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byKey(const ValueKey('second-appbar'))).dy),
    );

    // 노출 시간이 지나면 토스트가 자동으로 제거되는지 확인.
    await tester.pump(const Duration(seconds: 20));
    await tester.pumpAndSettle();
    expect(find.byType(GdsToast), findsNothing);

    // 화면을 제거하면 등록된 오버레이도 정리되는지 확인.
    await tester.pumpWidget(const SizedBox());
    expect(() => GdsOverlay.current, throwsStateError);
  });
}
