import 'package:flutter/material.dart';
import 'package:gds_tokens/gds_tokens.dart';

import '../gds_colors.dart';
import '../gds_typography.dart';

/// Grimity Design System 테마.
///
/// Material [ThemeData]에 gds 토큰(색상·타이포그래피)을 매핑해 제공합니다.
/// [MaterialApp]의 `theme`/`darkTheme`에 그대로 주입해 사용합니다.
///
/// ## 사용 예시
/// ```dart
/// MaterialApp(
///   theme: GdsTheme.light(),
///   darkTheme: GdsTheme.dark(),
/// )
/// ```
class GdsTheme {
  const GdsTheme._();

  /// Light 모드 [ThemeData].
  static ThemeData light() => _build(
        brightness: Brightness.light,
        colors: GdsColors.light,
      );

  /// Dark 모드 [ThemeData].
  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        colors: GdsColors.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required GdsSemanticColor colors,
  }) {
    final textColor = colors.text.grayBold;
    TextStyle withColor(TextStyle base) => base.copyWith(color: textColor);

    return ThemeData(
      brightness: brightness,
      fontFamily: GdsTypography.fontFamily,
      scaffoldBackgroundColor: colors.bg.primary,
      iconTheme: IconThemeData(color: colors.icon.grayBold),
      textTheme: TextTheme(
        displayLarge: withColor(GdsTypography.title1),
        displayMedium: withColor(GdsTypography.title2),
        displaySmall: withColor(GdsTypography.title3),
        headlineLarge: withColor(GdsTypography.title1),
        headlineMedium: withColor(GdsTypography.title2),
        headlineSmall: withColor(GdsTypography.title3),
        titleLarge: withColor(GdsTypography.subtitle1),
        titleMedium: withColor(GdsTypography.subtitle2),
        titleSmall: withColor(GdsTypography.subtitle3),
        bodyLarge: withColor(GdsTypography.body1R),
        bodyMedium: withColor(GdsTypography.body2R),
        bodySmall: withColor(GdsTypography.caption1),
        labelLarge: withColor(GdsTypography.label1),
        labelMedium: withColor(GdsTypography.label2),
        labelSmall: withColor(GdsTypography.label3),
      ),
    );
  }
}

extension GdsThemeExtension on BuildContext {
  GdsSemanticColor get gdsColors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.light ? GdsColors.light : GdsColors.dark;
  }
}
