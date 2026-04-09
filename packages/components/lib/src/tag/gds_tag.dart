import 'package:flutter/widgets.dart';
import 'package:gds_components/src/common/common.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsTagSize {
  medium,
  small;

  EdgeInsets padding({required bool isIconType}) => switch ((this, isIconType)) {
    (GdsTagSize.medium, false) => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    (GdsTagSize.small, false) => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    (GdsTagSize.medium, true) => const EdgeInsets.fromLTRB(16, 8, 12, 8),
    (GdsTagSize.small, true) => const EdgeInsets.fromLTRB(12, 6, 10, 6),
  };
}

enum GdsTagState {
  enabled,
  disabled;

  Color textColor(GdsSemanticColor colors) => switch (this) {
    GdsTagState.enabled => colors.text.grayBold,
    GdsTagState.disabled => colors.text.graySubtler,
  };

  Color iconColor(GdsSemanticColor colors) => switch (this) {
    GdsTagState.enabled => colors.icon.grayBold,
    GdsTagState.disabled => colors.icon.graySubtler,
  };

  Color backgroundColor(GdsSemanticColor colors) => switch (this) {
    GdsTagState.enabled => colors.surface.graySubtler,
    GdsTagState.disabled => colors.surface.graySubtlest,
  };
}

class GdsTag extends StatelessWidget {
  final String text;
  final GdsIcon? icon;
  final GdsTagSize size;
  final GdsTagState state;
  final VoidCallback? onTap;

  const GdsTag({
    super.key,
    required this.text,
    this.size = GdsTagSize.medium,
    this.state = GdsTagState.enabled,
    this.onTap,
  }) : icon = null;

  const GdsTag.icon({
    super.key,
    required this.text,
    this.icon,
    this.size = GdsTagSize.medium,
    this.state = GdsTagState.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final textStyle = GdsTypography.label4;
    final tagPadding = size.padding(isIconType: icon != null);

    return GdsGesture(
      onTap: state == GdsTagState.enabled ? onTap : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: state.backgroundColor(colors),
          borderRadius: BorderRadius.circular(GdsRadius.full),
        ),
        child: Padding(
          padding: tagPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: textStyle.copyWith(
                  color: state.textColor(colors),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 4),
                icon!.build(
                  width: GdsIconSize.v16,
                  height: GdsIconSize.v16,
                  color: state.iconColor(colors),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
