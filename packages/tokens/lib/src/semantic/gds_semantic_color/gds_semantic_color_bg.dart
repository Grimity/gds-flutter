part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorBg {
  const GdsSemanticColorBg();

  Color get primary;

  Color get secondary;

  Color get tertiary;

  Color get black;

  Color get overlayBlack;

  static const GdsSemanticColorBg light = _GdsSemanticColorBgLight();
  static const GdsSemanticColorBg dark = _GdsSemanticColorBgDark();
}

class _GdsSemanticColorBgLight extends GdsSemanticColorBg {
  const _GdsSemanticColorBgLight();

  @override
  Color get primary => GdsAtomicColorBase.white;

  @override
  Color get secondary => GdsAtomicColorGray.v10;

  @override
  Color get tertiary => GdsAtomicColorGray.v30;

  @override
  Color get black => GdsAtomicColorBase.black;

  @override
  Color get overlayBlack => GdsAtomicColorBase.black.withValues(alpha: GdsAtomicOpacity.a40);
}

class _GdsSemanticColorBgDark extends GdsSemanticColorBg {
  const _GdsSemanticColorBgDark();

  @override
  Color get primary => GdsAtomicColorGray.v100;

  @override
  Color get secondary => GdsAtomicColorGray.v90;

  @override
  Color get tertiary => GdsAtomicColorGray.v70;

  @override
  Color get black => GdsAtomicColorBase.black;

  @override
  Color get overlayBlack => GdsAtomicColorBase.black.withValues(alpha: GdsAtomicOpacity.a80);
}
