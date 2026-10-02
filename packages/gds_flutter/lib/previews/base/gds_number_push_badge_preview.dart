import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsPushBadge.number]에 대한 프리뷰 위젯.
class GdsNumberPushBadgePreview extends PreviewWidget {
  final variantControl = PreviewControl.select<GdsNumberPushBadgeVariant>(
    defaultValue: .solid,
    displayName: 'Variant',
    values: GdsNumberPushBadgeVariant.values,
  );

  final valueControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Value',
    minValue: 0,
    maxValue: 99,
  );

  @override
  String get displayName => 'Push Badge · Number';

  @override
  List<String> get groups => ['Base'];

  @override
  Widget build(BuildContext context) {
    final variant = variantControl.of(context);
    final value = valueControl.of(context);

    return GdsPushBadge.number(
      variant: variant.value,
      value: value.value,
    );
  }
}
