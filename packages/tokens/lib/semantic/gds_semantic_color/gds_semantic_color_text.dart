part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorText {
  const GdsSemanticColorText();

  Color get white;

  Color get black;

  Color get inverse;

  Color get grayBold;

  Color get grayNormal;

  Color get graySubtle;

  Color get graySubtler;

  Color get primaryNormal;

  Color get primarySubtle;

  static const GdsSemanticColorText light = _GdsSemanticColorTextLight();
  static const GdsSemanticColorText dark = _GdsSemanticColorTextDark();
}

class _GdsSemanticColorTextLight extends GdsSemanticColorText {
  const _GdsSemanticColorTextLight();

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get black => GdsAtomicColorBase.black;

  @override
  Color get inverse => GdsAtomicColorBase.white;

  @override
  Color get grayBold => GdsAtomicColorGray.v90;

  @override
  Color get grayNormal => GdsAtomicColorGray.v70;

  @override
  Color get graySubtle => GdsAtomicColorGray.v50;

  @override
  Color get graySubtler => GdsAtomicColorGray.v30;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v60;

  @override
  Color get primarySubtle => GdsAtomicColorGreen.v30;
}

class _GdsSemanticColorTextDark extends GdsSemanticColorText {
  const _GdsSemanticColorTextDark();

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get black => GdsAtomicColorBase.black;

  @override
  Color get inverse => GdsAtomicColorGray.v90;

  @override
  Color get grayBold => GdsAtomicColorGray.v20;

  @override
  Color get grayNormal => GdsAtomicColorGray.v40;

  @override
  Color get graySubtle => GdsAtomicColorGray.v60;

  @override
  Color get graySubtler => GdsAtomicColorGray.v80;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v50;

  @override
  Color get primarySubtle => GdsAtomicColorGreen.v100;
}
