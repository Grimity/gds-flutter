import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

class GdsCheckmark extends StatelessWidget {
  final bool isChecked;
  final bool enabled;
  final VoidCallback onTap;
  final double size;

  const GdsCheckmark({
    super.key,
    required this.isChecked,
    required this.onTap,
    this.enabled = true,
    this.size = GdsIconSize.defaultSize,
  });

  Color _iconColor(GdsSemanticColor colors) {
    if (isChecked && !enabled) return colors.icon.primarySubtle;
    if (isChecked) return colors.icon.primaryNormal;
    if (!enabled) return colors.icon.graySubtlest;
    return colors.icon.graySubtle;
  }

  static GdsIcon icon() => GdsIcon.check;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: icon().build(
        color: _iconColor(colors),
        width: size,
        height: size,
      ),
    );
  }
}
