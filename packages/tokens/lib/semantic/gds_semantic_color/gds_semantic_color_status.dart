part of '../gds_semantic_color.dart';

abstract class GdsSemanticColorStatus {
  const GdsSemanticColorStatus();

  Color get positive;

  Color get info;

  Color get negative;

  Color get cautionary;

  Color get notification;

  static const GdsSemanticColorStatus light = _GdsSemanticColorStatusLight();
  static const GdsSemanticColorStatus dark = _GdsSemanticColorStatusDark();
}

class _GdsSemanticColorStatusLight extends GdsSemanticColorStatus {
  const _GdsSemanticColorStatusLight();

  @override
  Color get positive => GdsAtomicColorGreen.v60;

  @override
  Color get info => GdsAtomicColorBlue.v60;

  @override
  Color get negative => GdsAtomicColorRed.v70;

  @override
  Color get cautionary => GdsAtomicColorOrange.v60;

  @override
  Color get notification => GdsAtomicColorRed.v60;
}

class _GdsSemanticColorStatusDark extends GdsSemanticColorStatus {
  const _GdsSemanticColorStatusDark();

  @override
  Color get positive => GdsAtomicColorGreen.v50;

  @override
  Color get info => GdsAtomicColorBlue.v50;

  @override
  Color get negative => GdsAtomicColorRed.v60;

  @override
  Color get cautionary => GdsAtomicColorOrange.v50;

  @override
  Color get notification => GdsAtomicColorRed.v50;
}
