import 'package:flutter/widgets.dart';

import '../atomic/atomic.dart';

part 'gds_semantic_color/gds_semantic_color_bg.dart';
part 'gds_semantic_color/gds_semantic_color_surface.dart';
part 'gds_semantic_color/gds_semantic_color_text.dart';
part 'gds_semantic_color/gds_semantic_color_icon.dart';
part 'gds_semantic_color/gds_semantic_color_border.dart';
part 'gds_semantic_color/gds_semantic_color_status.dart';
part 'gds_semantic_color/gds_semantic_color_graphic.dart';

class GdsSemanticColor {
  final GdsSemanticColorBg bg;
  final GdsSemanticColorSurface surface;
  final GdsSemanticColorText text;
  final GdsSemanticColorIcon icon;
  final GdsSemanticColorBorder border;
  final GdsSemanticColorStatus status;
  final GdsSemanticColorGraphic graphic;

  const GdsSemanticColor._({
    required this.bg,
    required this.surface,
    required this.text,
    required this.icon,
    required this.border,
    required this.status,
    required this.graphic,
  });

  static const light = GdsSemanticColor._(
    bg: GdsSemanticColorBg.light,
    surface: GdsSemanticColorSurface.light,
    text: GdsSemanticColorText.light,
    icon: GdsSemanticColorIcon.light,
    border: GdsSemanticColorBorder.light,
    status: GdsSemanticColorStatus.light,
    graphic: GdsSemanticColorGraphic.light,
  );

  static const dark = GdsSemanticColor._(
    bg: GdsSemanticColorBg.dark,
    surface: GdsSemanticColorSurface.dark,
    text: GdsSemanticColorText.dark,
    icon: GdsSemanticColorIcon.dark,
    border: GdsSemanticColorBorder.dark,
    status: GdsSemanticColorStatus.dark,
    graphic: GdsSemanticColorGraphic.dark,
  );
}
