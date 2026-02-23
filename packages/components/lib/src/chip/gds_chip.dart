import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsChipVariant {
  primary,
  assistive;

  TextStyle get textStyle => switch (this) {
    GdsChipVariant.primary => GdsTypography.label6,
    GdsChipVariant.assistive => GdsTypography.label5,
  };

  Color backgroundColor(GdsSemanticColor colors) => switch (this) {
    GdsChipVariant.primary => colors.surface.primarySubtlest,
    GdsChipVariant.assistive => colors.surface.graySubtlest,
  };

  Color textColor(GdsSemanticColor colors) => switch (this) {
    GdsChipVariant.primary => colors.text.primaryNormal,
    GdsChipVariant.assistive => colors.text.grayNormal,
  };

  BoxBorder border(GdsSemanticColor colors) => switch (this) {
    GdsChipVariant.primary => Border.all(color: colors.border.primarySubtle, width: 1),
    GdsChipVariant.assistive => Border.all(color: colors.border.graySubtler, width: 1),
  };
}

enum GdsChipSize {
  xLarge,
  medium;

  double get horizontalPadding => switch (this) {
    GdsChipSize.xLarge => GdsSpacing.spacing10,
    GdsChipSize.medium => GdsSpacing.spacing8,
  };
}

class GdsChip extends StatelessWidget {
  final String text;
  final GdsChipVariant variant;
  final GdsChipSize size;

  const GdsChip({
    super.key,
    required this.text,
    this.variant = GdsChipVariant.primary,
    required this.size,
  });

  const GdsChip.xLarge({
    super.key,
    required this.text,
    this.variant = GdsChipVariant.primary,
  }) : size = GdsChipSize.xLarge;

  const GdsChip.medium({
    super.key,
    required this.text,
    this.variant = GdsChipVariant.primary,
  }) : size = GdsChipSize.medium;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.horizontalPadding),
      decoration: BoxDecoration(
        color: variant.backgroundColor(colors),
        borderRadius: BorderRadius.circular(GdsRadius.full),
        border: variant.border(colors),
      ),
      child: Text(
        text,
        style: variant.textStyle.copyWith(
          color: variant.textColor(colors),
        ),
      ),
    );
  }
}
