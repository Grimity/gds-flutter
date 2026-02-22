part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorGraphic {
  const GdsSemanticColorGraphic();

  Color get white;

  Color get primary;

  Color get bold;

  Color get normal;

  Color get subtle;

  Color get subtler;

  static const GdsSemanticColorGraphic light = _GdsSemanticColorGraphicLight();
  static const GdsSemanticColorGraphic dark = _GdsSemanticColorGraphicDark();
}

class _GdsSemanticColorGraphicLight extends GdsSemanticColorGraphic {
  const _GdsSemanticColorGraphicLight();

  @override
  Color get white => GdsAtomicColorBase.white;

  @override
  Color get primary => GdsAtomicColorGreen.v60;

  @override
  Color get bold => GdsAtomicColorGray.v90;

  @override
  Color get normal => GdsAtomicColorGray.v80;

  @override
  Color get subtle => GdsAtomicColorGray.v60;

  @override
  Color get subtler => GdsAtomicColorGray.v40;
}

class _GdsSemanticColorGraphicDark extends GdsSemanticColorGraphic {
  const _GdsSemanticColorGraphicDark();

  @override
  Color get white => GdsAtomicColorGray.v100;

  @override
  Color get primary => GdsAtomicColorGreen.v50;

  @override
  Color get bold => GdsAtomicColorGray.v10;

  @override
  Color get normal => GdsAtomicColorGray.v30;

  @override
  Color get subtle => GdsAtomicColorGray.v50;

  @override
  Color get subtler => GdsAtomicColorGray.v70;
}
