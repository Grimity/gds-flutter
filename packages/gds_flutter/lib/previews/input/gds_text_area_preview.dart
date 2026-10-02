import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTextArea]에 대한 프리뷰 위젯.
class GdsTextAreaPreview extends PreviewWidget {
  final variantControl = PreviewControl.select<GdsTextAreaVariant>(
    defaultValue: .normal,
    displayName: 'Variant',
    values: GdsTextAreaVariant.values,
  );

  final statusControl = PreviewControl.select<GdsInputStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: GdsInputStatus.values,
  );

  final placeholderControl = PreviewControl.string(
    initialValue: 'Placeholder',
    displayName: 'Placeholder',
  );

  final maxLengthControl = PreviewControl.integer(
    defaultValue: 250,
    displayName: 'Max Length',
    minValue: 1,
    maxValue: 500,
  );

  @override
  String get displayName => 'Text Area';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final variant = variantControl.of(context);
    final status = statusControl.of(context);
    final placeholder = placeholderControl.of(context);
    final maxLength = maxLengthControl.of(context);

    return GdsTextArea(
      variant: variant.value,
      status: status.value,
      placeholder: placeholder.mayBeValue,
      maxLength: maxLength.value,
    );
  }
}
