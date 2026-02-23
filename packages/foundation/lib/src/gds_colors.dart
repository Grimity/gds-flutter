import 'package:flutter/widgets.dart';
import 'package:gds_tokens/gds_tokens.dart';

/// Grimity Design System 색상
///
/// ## 사용 예시
/// ```dart
/// // Atomic 색상 직접 접근
/// GdsColors.white
/// GdsColors.gray50
/// GdsColors.green60
///
/// // Semantic 테마 색상 접근
/// GdsColors.light.text.grayBold
/// GdsColors.dark.bg.primary
/// ```
class GdsColors {
  const GdsColors._();

  // ===== Semantic (테마 색상) =====

  static const GdsSemanticColor light = GdsSemanticColor.light;
  static const GdsSemanticColor dark = GdsSemanticColor.dark;

  // ===== Base =====

  static const Color white = GdsAtomicColorBase.white;
  static const Color black = GdsAtomicColorBase.black;
  static const Color transparent = GdsAtomicColorBase.transparent;

  // ===== Gray =====

  static const Color gray10 = GdsAtomicColorGray.v10;
  static const Color gray20 = GdsAtomicColorGray.v20;
  static const Color gray30 = GdsAtomicColorGray.v30;
  static const Color gray40 = GdsAtomicColorGray.v40;
  static const Color gray50 = GdsAtomicColorGray.v50;
  static const Color gray60 = GdsAtomicColorGray.v60;
  static const Color gray70 = GdsAtomicColorGray.v70;
  static const Color gray80 = GdsAtomicColorGray.v80;
  static const Color gray90 = GdsAtomicColorGray.v90;
  static const Color gray100 = GdsAtomicColorGray.v100;

  // ===== Blue =====

  static const Color blue10 = GdsAtomicColorBlue.v10;
  static const Color blue20 = GdsAtomicColorBlue.v20;
  static const Color blue30 = GdsAtomicColorBlue.v30;
  static const Color blue40 = GdsAtomicColorBlue.v40;
  static const Color blue50 = GdsAtomicColorBlue.v50;
  static const Color blue60 = GdsAtomicColorBlue.v60;
  static const Color blue70 = GdsAtomicColorBlue.v70;
  static const Color blue80 = GdsAtomicColorBlue.v80;
  static const Color blue90 = GdsAtomicColorBlue.v90;
  static const Color blue100 = GdsAtomicColorBlue.v100;

  // ===== Green =====

  static const Color green10 = GdsAtomicColorGreen.v10;
  static const Color green20 = GdsAtomicColorGreen.v20;
  static const Color green30 = GdsAtomicColorGreen.v30;
  static const Color green40 = GdsAtomicColorGreen.v40;
  static const Color green50 = GdsAtomicColorGreen.v50;
  static const Color green60 = GdsAtomicColorGreen.v60;
  static const Color green70 = GdsAtomicColorGreen.v70;
  static const Color green80 = GdsAtomicColorGreen.v80;
  static const Color green90 = GdsAtomicColorGreen.v90;
  static const Color green100 = GdsAtomicColorGreen.v100;

  // ===== Orange =====

  static const Color orange10 = GdsAtomicColorOrange.v10;
  static const Color orange20 = GdsAtomicColorOrange.v20;
  static const Color orange30 = GdsAtomicColorOrange.v30;
  static const Color orange40 = GdsAtomicColorOrange.v40;
  static const Color orange50 = GdsAtomicColorOrange.v50;
  static const Color orange60 = GdsAtomicColorOrange.v60;
  static const Color orange70 = GdsAtomicColorOrange.v70;
  static const Color orange80 = GdsAtomicColorOrange.v80;
  static const Color orange90 = GdsAtomicColorOrange.v90;
  static const Color orange100 = GdsAtomicColorOrange.v100;

  // ===== Red =====

  static const Color red10 = GdsAtomicColorRed.v10;
  static const Color red20 = GdsAtomicColorRed.v20;
  static const Color red30 = GdsAtomicColorRed.v30;
  static const Color red40 = GdsAtomicColorRed.v40;
  static const Color red50 = GdsAtomicColorRed.v50;
  static const Color red60 = GdsAtomicColorRed.v60;
  static const Color red70 = GdsAtomicColorRed.v70;
  static const Color red80 = GdsAtomicColorRed.v80;
  static const Color red90 = GdsAtomicColorRed.v90;
  static const Color red100 = GdsAtomicColorRed.v100;
}
