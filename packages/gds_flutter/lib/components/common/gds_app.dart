import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 디자인 시스템에서 테마와 공통 스크롤 설정을 적용하는 앱의 최상위 위젯.
class GdsApp extends StatelessWidget {
  const new({
    super.key,
    required this.themeMode,
    required this.initialPage,
  });

  final ThemeMode themeMode;
  final Widget initialPage;

  /// 앱의 내비게이터 상태에 전역으로 접근하기 위한 키.
  static final navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: .light(),
      darkTheme: .dark(),
      themeMode: themeMode,
      navigatorKey: navigationKey,
      scrollBehavior: GdsScrollBehavior(),
      builder: (context, child) {
        return ServiceScope.withState(
          child: GdsThemeScope(
            theme: themeMode.theme,
            child: child!,
          ),
        );
      },
      home: initialPage,
    );
  }
}
