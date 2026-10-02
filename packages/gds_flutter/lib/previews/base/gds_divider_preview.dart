import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsDivider]에 대한 프리뷰 위젯.
class GdsDividerPreview extends PreviewWidget {
  final boldControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Bold',
  );

  final verticalControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Vertical',
  );

  final variantControl = PreviewControl.select<GdsDividerVariant>(
    defaultValue: .brand,
    displayName: 'Variant',
    values: GdsDividerVariant.values,
  );

  @override
  String get displayName => 'Divider';

  @override
  List<String> get groups => ['Base'];

  @override
  Widget build(BuildContext context) {
    final bold = boldControl.of(context);
    final vertical = verticalControl.of(context);
    final variant = variantControl.of(context);

    return GdsDivider(
      bold: bold.value,
      vertical: vertical.value,
      variant: variant.value,
    );
  }
}
