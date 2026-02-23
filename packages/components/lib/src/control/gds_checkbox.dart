import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsCheckboxSize {
  medium,
  small;

  double get iconSize => switch (this) {
    GdsCheckboxSize.medium => GdsIconSize.v24,
    GdsCheckboxSize.small => GdsIconSize.v16,
  };
}

class GdsCheckbox extends StatelessWidget {
  final bool isChecked;
  final bool enabled;
  final GdsCheckboxSize size;
  final VoidCallback onTap;

  const GdsCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
    this.enabled = true,
  }) : size = GdsCheckboxSize.medium;

  const GdsCheckbox.small({
    super.key,
    required this.isChecked,
    required this.onTap,
    this.enabled = true,
  }) : size = GdsCheckboxSize.small;

  Color _iconColor(GdsSemanticColor colors) {
    if (isChecked) return colors.icon.primaryNormal;
    if (!enabled) return colors.icon.graySubtlest;
    return colors.icon.graySubtler;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = isChecked ? GdsIcon.checkSquareFill : GdsIcon.checkSquareOutline;

    return GdsIconAnimationButton(
      onTap: onTap,
      child: icon.build(
        color: _iconColor(colors),
        width: size.iconSize,
        height: size.iconSize,
      ),
    );
  }
}
