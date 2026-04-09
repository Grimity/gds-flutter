import 'package:flutter/widgets.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

class GdsToggle extends StatelessWidget {
  final bool isOn;
  final bool enabled;
  final VoidCallback onTap;

  const GdsToggle({
    super.key,
    required this.isOn,
    required this.onTap,
    this.enabled = true,
  });

  static const double _trackWidth = 52;
  static const double _trackHeight = 32;
  static const double _thumbSize = 24;
  static const double _padding = 4;

  Color _trackColor(GdsSemanticColor colors) => isOn ? colors.surface.primaryNormal : colors.surface.graySubtle;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: _trackWidth,
          height: _trackHeight,
          padding: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(
            color: _trackColor(colors),
            borderRadius: BorderRadius.circular(GdsRadius.full),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: _thumbSize,
              height: _thumbSize,
              decoration: BoxDecoration(
                color: colors.surface.white,
                borderRadius: BorderRadius.circular(GdsRadius.full),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
