part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorIcon {
  const GdsSemanticColorIcon();

  Color get white;

  Color get base;

  Color get inverse;

  Color get grayBold;

  Color get grayNormal;

  Color get graySubtle;

  Color get graySubtler;

  Color get graySubtlest;

  Color get primaryNormal;

  Color get primarySubtle;

  static const GdsSemanticColorIcon light = _GdsSemanticColorIconLight();
  static const GdsSemanticColorIcon dark = _GdsSemanticColorIconDark();
}

class _GdsSemanticColorIconLight extends GdsSemanticColorIcon {
  const _GdsSemanticColorIconLight();

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get base => GdsAtomicColorBase.black;

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
  Color get graySubtlest => GdsAtomicColorGray.v20;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v60;

  @override
  Color get primarySubtle => GdsAtomicColorGreen.v30;
}

class _GdsSemanticColorIconDark extends GdsSemanticColorIcon {
  const _GdsSemanticColorIconDark();

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get base => GdsAtomicColorBase.white;

  @override
  Color get inverse => GdsAtomicColorBase.black;

  @override
  Color get grayBold => GdsAtomicColorGray.v20;

  @override
  Color get grayNormal => GdsAtomicColorGray.v40;

  @override
  Color get graySubtle => GdsAtomicColorGray.v60;

  @override
  Color get graySubtler => GdsAtomicColorGray.v80;

  @override
  Color get graySubtlest => GdsAtomicColorGray.v90;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v50;

  @override
  Color get primarySubtle => GdsAtomicColorGreen.v100;
}
