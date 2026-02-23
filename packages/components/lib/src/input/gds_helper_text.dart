import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsHelperTextState {
  normal,
  error,
  success;

  Color textColor(GdsSemanticColor colors) => switch (this) {
    GdsHelperTextState.normal => colors.text.grayBold,
    GdsHelperTextState.error => colors.status.negative,
    GdsHelperTextState.success => colors.status.positive,
  };

  GdsIcon? get icon => switch (this) {
    GdsHelperTextState.normal => null,
    GdsHelperTextState.error => GdsIcon.xMark,
    GdsHelperTextState.success => GdsIcon.check,
  };
}

class GdsHelperText extends StatelessWidget {
  final GdsHelperTextState state;
  final String? text;
  final int? currentCount;
  final int? maxCount;

  const GdsHelperText({
    super.key,
    this.state = GdsHelperTextState.normal,
    this.text,
    this.currentCount,
    this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = state.icon;
    final textColor = state.textColor(colors);

    final bool hasLeft = text != null || icon != null;
    final bool hasCount = currentCount != null;

    if (!hasLeft && !hasCount) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (hasLeft)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon.build(
                    color: textColor,
                    width: GdsIconSize.v16,
                    height: GdsIconSize.v16,
                  ),
                  const SizedBox(width: GdsSpacing.spacing2),
                ],
                if (text != null)
                  Expanded(
                    child: Text(
                      text!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GdsTypography.caption1.copyWith(color: textColor),
                    ),
                  ),
              ],
            ),
          ),
        if (hasCount) ...[
          if (hasLeft) const SizedBox(width: GdsSpacing.spacing8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$currentCount',
                  style: GdsTypography.caption1.copyWith(
                    color: colors.text.grayNormal,
                  ),
                ),
                if (maxCount != null)
                  TextSpan(
                    text: '/$maxCount',
                    style: GdsTypography.caption1.copyWith(
                      color: colors.text.graySubtle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
