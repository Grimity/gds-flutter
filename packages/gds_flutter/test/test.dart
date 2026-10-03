import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 테스트용 테마 목록.
final testThemes = <GdsTheme>[.light(), .dark()];

/// 테스트용 앱 래퍼 위젯.
class TestApp extends StatelessWidget {
  const new({
    super.key,
    this.theme,
    required this.body,
  });

  final GdsTheme? theme;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .ltr,
      child: GdsThemeScope(
        theme: theme ?? .light(),
        child: GdsScaffold(body: body),
      ),
    );
  }
}
