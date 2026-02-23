import 'package:flutter/material.dart';
import 'package:gds_tokens/gds_tokens.dart';

import '../gds_colors.dart';

extension GdsTheme on BuildContext {
  GdsSemanticColor get gdsColors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.light ? GdsColors.light : GdsColors.dark;
  }
}
