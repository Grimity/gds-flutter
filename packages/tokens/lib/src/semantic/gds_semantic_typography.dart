import 'package:flutter/widgets.dart';

import '../atomic/atomic.dart';

class GdsSemanticTypography {
  const GdsSemanticTypography._();

  static const TextStyle title1 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.bold,
    fontSize: GdsAtomicFontSize.xxl,
    height: GdsAtomicFontLineHeight.sm,
    letterSpacing: 0,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.bold,
    fontSize: GdsAtomicFontSize.xl,
    height: GdsAtomicFontLineHeight.sm,
    letterSpacing: 0,
  );

  static const TextStyle title3 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.bold,
    fontSize: GdsAtomicFontSize.lg,
    height: GdsAtomicFontLineHeight.sm,
    letterSpacing: 0,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.bold,
    fontSize: GdsAtomicFontSize.ml,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing: 0,
  );

  static final TextStyle subtitle2 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.bold,
    fontSize: GdsAtomicFontSize.md,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.md * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle subtitle3 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.bold,
    fontSize: GdsAtomicFontSize.sm,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.sm * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle body1R = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.regular,
    fontSize: GdsAtomicFontSize.md,
    height: GdsAtomicFontLineHeight.lg,
    letterSpacing:
        GdsAtomicFontSize.md * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle body1SB = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.semiBold,
    fontSize: GdsAtomicFontSize.md,
    height: GdsAtomicFontLineHeight.lg,
    letterSpacing:
        GdsAtomicFontSize.md * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle body2R = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.regular,
    fontSize: GdsAtomicFontSize.sm,
    height: GdsAtomicFontLineHeight.lg,
    letterSpacing:
        GdsAtomicFontSize.sm * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle body2SB = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.semiBold,
    fontSize: GdsAtomicFontSize.sm,
    height: GdsAtomicFontLineHeight.lg,
    letterSpacing:
        GdsAtomicFontSize.sm * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle caption1 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.regular,
    fontSize: GdsAtomicFontSize.xs,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.xs * (GdsAtomicFontLetterSpacing.tighter / 100),
  );

  static final TextStyle label1 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.semiBold,
    fontSize: GdsAtomicFontSize.md,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.md * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle label2 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.medium,
    fontSize: GdsAtomicFontSize.md,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.md * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle label3 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.semiBold,
    fontSize: GdsAtomicFontSize.sm,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.sm * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle label4 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.medium,
    fontSize: GdsAtomicFontSize.sm,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.sm * (GdsAtomicFontLetterSpacing.tight / 100),
  );

  static final TextStyle label5 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.semiBold,
    fontSize: GdsAtomicFontSize.xs,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.xs * (GdsAtomicFontLetterSpacing.tighter / 100),
  );

  static final TextStyle label6 = TextStyle(
    fontFamily: GdsAtomicFontFamily.pretendard,
    fontWeight: GdsAtomicFontWeight.medium,
    fontSize: GdsAtomicFontSize.xs,
    height: GdsAtomicFontLineHeight.md,
    letterSpacing:
        GdsAtomicFontSize.xs * (GdsAtomicFontLetterSpacing.tighter / 100),
  );
}
