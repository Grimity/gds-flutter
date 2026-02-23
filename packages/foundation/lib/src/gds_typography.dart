import 'package:flutter/widgets.dart';
import 'package:gds_tokens/gds_tokens.dart';

/// Grimity Design System 타이포그래피
///
/// ## 사용 예시
/// ```dart
/// // Font Family
/// GdsTypography.fontFamily
///
/// // TextStyle
/// GdsTypography.title1
/// GdsTypography.body1R
/// ```
class GdsTypography {
  const GdsTypography._();

  // ===== Font Family =====

  static const String fontFamily = GdsAtomicFontFamily.pretendard;

  // ===== Text Styles =====

  static const TextStyle title1 = GdsSemanticTypography.title1;
  static const TextStyle title2 = GdsSemanticTypography.title2;
  static const TextStyle title3 = GdsSemanticTypography.title3;
  static const TextStyle subtitle1 = GdsSemanticTypography.subtitle1;
  static final TextStyle subtitle2 = GdsSemanticTypography.subtitle2;
  static final TextStyle subtitle3 = GdsSemanticTypography.subtitle3;
  static final TextStyle body1R = GdsSemanticTypography.body1R;
  static final TextStyle body1SB = GdsSemanticTypography.body1SB;
  static final TextStyle body2R = GdsSemanticTypography.body2R;
  static final TextStyle body2SB = GdsSemanticTypography.body2SB;
  static final TextStyle caption1 = GdsSemanticTypography.caption1;
  static final TextStyle label1 = GdsSemanticTypography.label1;
  static final TextStyle label2 = GdsSemanticTypography.label2;
  static final TextStyle label3 = GdsSemanticTypography.label3;
  static final TextStyle label4 = GdsSemanticTypography.label4;
  static final TextStyle label5 = GdsSemanticTypography.label5;
  static final TextStyle label6 = GdsSemanticTypography.label6;
}
