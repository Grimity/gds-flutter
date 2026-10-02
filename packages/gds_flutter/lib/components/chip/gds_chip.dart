import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11138-187896&t=aC4Dz1qXNpQSETGX-4
@GdsSupportedSizes([.xl, .md])
class GdsChip extends StatelessWidget {
  const GdsChip({
    super.key,
    required this.variant,
    required this.size,
    required this.label,
  });

  final GdsChipVariant variant;
  final GdsSize size;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      height: size.when(xl: 24, md: 22),
      radius: .full,
      border: .all(color: variant.borderColor),
      alignment: .center,
      padding: size.when(
        xl: 10.horizontal,
        md: 8.horizontal,
      ),
      color: variant.backgroundColor,
      child: GdsText(
        label,
        color: variant.labelColor,
        style: variant.labelStyle,
      ),
    );
  }
}
