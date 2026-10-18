import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';

void main() {
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
