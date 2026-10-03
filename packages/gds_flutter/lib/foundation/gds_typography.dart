import 'package:flutter/widgets.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=9159-121272&m=dev
enum GdsTypography {
  // Title
  title1(.w700, 28, 1.2, 0),
  title2(.w700, 24, 1.2, 0),
  title3(.w700, 20, 1.2, 0),

  // Subtitle
  subtitle1(.w700, 18, 1.4, 0),
  subtitle2(.w600, 16, 1.4, -0.2),
  subtitle3(.w600, 14, 1.4, -0.2),

  // Body
  body1R(.w400, 16, 1.6, -0.2),
  body1SB(.w600, 16, 1.6, -0.2),
  body2R(.w400, 14, 1.6, -0.2),
  body2SB(.w600, 14, 1.6, -0.2),

  // Caption
  caption1(.w400, 12, 1.4, -0.8),

  // Label
  label1(.w600, 16, 1.4, -0.2),
  label2(.w500, 16, 1.4, -0.2),
  label3(.w600, 14, 1.4, -0.2),
  label4(.w500, 14, 1.4, -0.2),
  label5(.w600, 12, 1.4, -0.8),
  label6(.w500, 12, 1.4, -0.8),

  // Editor
  editorTitle1(.w700, 20, 1.5, 0),
  editorTitle2(.w600, 16, 1.5, 0),
  editorBody(.w400, 14, 1.6, 0);

  const new(
    this.fontWeight,
    this.fontSize,
    this.lineHeight,
    this.letterSpacing,
  );

  final FontWeight fontWeight;
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;

  /// 앱 전역에서 사용되는 폰트.
  static const String fontFamily = 'Pretendard';

  /// 해당 타이포그래피에 대한 적절한 폰트 스타일을 반환합니다.
  TextStyle get style => TextStyle(
    package: 'gds_flutter',
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontSize: fontSize,
    height: lineHeight,
    letterSpacing: letterSpacing,
  );
}
