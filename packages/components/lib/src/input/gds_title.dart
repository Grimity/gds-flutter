import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsTitle extends StatelessWidget {
  final String text;
  final bool isRequired;

  const GdsTitle({super.key, required this.text, this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = GdsTypography.label3;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: style.copyWith(color: colors.text.grayBold)),
        if (isRequired) ...[
          const SizedBox(width: GdsSpacing.spacing2),
          Text('*', style: style.copyWith(color: colors.status.negative)),
        ],
      ],
    );
  }
}
