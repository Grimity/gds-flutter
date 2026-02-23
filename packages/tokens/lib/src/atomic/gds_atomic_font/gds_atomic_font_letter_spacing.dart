part of '../gds_atomic_font.dart';

/// Letter Spacing 퍼센트 값
///
/// Figma 디자인 토큰의 letterSpacing 값과 1:1 매칭됩니다.
/// Flutter의 letterSpacing은 픽셀 단위이므로, 사용 시 다음과 같이 계산해야 합니다:
///
/// ```dart
/// letterSpacing: fontSize * (AtomicFontLetterSpacing.tight / 100)
/// // 예: 16 * (0.2 / 100) = 0.032px
/// ```
class GdsAtomicFontLetterSpacing {
  const GdsAtomicFontLetterSpacing._();

  static const double defaultV = 0.0;
  static const double tight = 0.2;
  static const double tighter = 0.8;
}
