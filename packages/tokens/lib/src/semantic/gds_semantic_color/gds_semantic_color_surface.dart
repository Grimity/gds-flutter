part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorSurface {
  const GdsSemanticColorSurface();

  Color get base;

  Color get white;

  Color get black;

  Color get inverse;

  Color get grayBold;

  Color get grayNormal;

  Color get graySubtle;

  Color get graySubtler;

  Color get graySubtlest;

  Color get primaryNormal;

  Color get primarySubtler;

  Color get primarySubtlest;

  static const GdsSemanticColorSurface light = _GdsSemanticColorSurfaceLight();
  static const GdsSemanticColorSurface dark = _GdsSemanticColorSurfaceDark();
}

class _GdsSemanticColorSurfaceLight extends GdsSemanticColorSurface {
  const _GdsSemanticColorSurfaceLight();

  @override
  Color get base => GdsAtomicColorBase.white;

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get black => GdsAtomicColorBase.black;

  @override
  Color get inverse => GdsAtomicColorGray.v100;

  @override
  Color get grayBold => GdsAtomicColorGray.v80;

  @override
  Color get grayNormal => GdsAtomicColorGray.v60;

  @override
  Color get graySubtle => GdsAtomicColorGray.v40;

  @override
  Color get graySubtler => GdsAtomicColorGray.v20;

  @override
  Color get graySubtlest => GdsAtomicColorGray.v10;

  @override
  Color get primaryNormal => GdsAtomicColorGreen.v60;

  @override
  Color get primarySubtler => GdsAtomicColorGreen.v30;

  @override
  Color get primarySubtlest => GdsAtomicColorGreen.v10;
}

class _GdsSemanticColorSurfaceDark extends GdsSemanticColorSurface {
  const _GdsSemanticColorSurfaceDark();

  @override
  Color get base => GdsAtomicColorGray.v100;

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get black => GdsAtomicColorBase.black;

  @override
  Color get inverse => GdsAtomicColorBase.white;

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
  Color get primaryNormal => GdsAtomicColorGreen.v70;

  @override
  Color get primarySubtler => GdsAtomicColorGreen.v80;

  @override
  Color get primarySubtlest => GdsAtomicColorGreen.v90;
}
