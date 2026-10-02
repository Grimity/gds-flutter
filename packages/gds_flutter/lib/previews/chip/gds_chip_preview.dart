import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsChip]에 대한 프리뷰 위젯.
class GdsChipPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .xl,
    displayName: 'Status',
    values: [.xl, .md],
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final variantControl = PreviewControl.select<GdsChipVariant>(
    defaultValue: .primary,
    displayName: 'Status',
    values: GdsChipVariant.values,
  );

  @override
  String get displayName => 'Chip';

  @override
  List<String> get groups => ['Chip'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final label = labelControl.of(context);
    final variant = variantControl.of(context);

    return IntrinsicWidth(
      child: GdsChip(
        size: size.value,
        label: label.value,
        variant: variant.value,
      ),
    );
  }
}
