import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

class GdsRadioButton extends StatelessWidget {
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  const GdsRadioButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.enabled = true,
  });

  static const double _size = 24;
  static const double _ringSize = 20;
  static const double _dotSize = 12;
  static const double _ringStrokeWidth = 2;

  Color _color(GdsSemanticColor colors) {
    if (isSelected && !enabled) return colors.icon.primarySubtle;
    if (isSelected) return colors.icon.primaryNormal;
    if (!enabled) return colors.icon.graySubtlest;
    return colors.icon.graySubtler;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final color = _color(colors);

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: _ringSize,
              height: _ringSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: _ringStrokeWidth),
              ),
            ),
            if (isSelected)
              Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
