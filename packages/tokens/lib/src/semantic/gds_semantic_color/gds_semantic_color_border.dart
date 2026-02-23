part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorBorder {
  const GdsSemanticColorBorder();

  Color get inverse;

  Color get primaryNormal;

  Color get primarySubtle;

  Color get primarySubtler;

  Color get grayBold;

  Color get grayNormal;

  Color get graySubtle;

  Color get graySubtler;

  static const GdsSemanticColorBorder light = _GdsSemanticColorBorderLight();
  static const GdsSemanticColorBorder dark = _GdsSemanticColorBorderDark();
}

class _GdsSemanticColorBorderLight extends GdsSemanticColorBorder {
  const _GdsSemanticColorBorderLight();

  @override
  Color get inverse => GdsAtomicColorBase.white;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v60;

  @override
  Color get primarySubtle => GdsAtomicColorGreen.v30;

  @override
  Color get primarySubtler => GdsAtomicColorGreen.v10;

  @override
  Color get grayBold => GdsAtomicColorGray.v90;

  @override
  Color get grayNormal => GdsAtomicColorGray.v40;

  @override
  Color get graySubtle => GdsAtomicColorGray.v30;

  @override
  Color get graySubtler => GdsAtomicColorGray.v20;
}

class _GdsSemanticColorBorderDark extends GdsSemanticColorBorder {
  const _GdsSemanticColorBorderDark();

  @override
  Color get inverse => GdsAtomicColorGray.v90;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v70;

  @override
  Color get primarySubtle => GdsAtomicColorGreen.v80;

  @override
  Color get primarySubtler => GdsAtomicColorGreen.v100;

  @override
  Color get grayBold => GdsAtomicColorGray.v70;

  @override
  Color get grayNormal => GdsAtomicColorGray.v70;

  @override
  Color get graySubtle => GdsAtomicColorGray.v80;

  @override
  Color get graySubtler => GdsAtomicColorGray.v90;
}
