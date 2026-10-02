import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 하위 위젯에 테마를 제공하는 위젯.
class GdsThemeScope extends InheritedWidget {
  const GdsThemeScope({
    super.key,
    required this.theme,
    required super.child,
  });

  /// 하위 위젯에 제공하는 테마.
  final GdsTheme theme;

  @override
  bool updateShouldNotify(covariant GdsThemeScope oldWidget) {
    return theme != oldWidget.theme;
  }

  /// 현재 컨텍스트에서 가장 가까운 테마를 반환하며, 없으면 null을 반환합니다.
  static GdsTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GdsThemeScope>()?.theme;
  }

  /// 현재 컨텍스트에서 가장 가까운 테마를 반환합니다.
  static GdsTheme of(BuildContext context) {
    final value = context.dependOnInheritedWidgetOfExactType<GdsThemeScope>()?.theme;
    if (value == null) {
      throw StateError('현재 컨텍스트에서는 테마를 찾을 수 없습니다.');
    }

    return value;
  }
}
