import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTextField.title]에 대한 프리뷰 위젯.
class GdsTitleTextFieldPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.md, .sm],
  );

  final statusControl = PreviewControl.select<GdsInputStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: GdsInputStatus.values,
  );

  final placeholderControl = PreviewControl.string(
    initialValue: 'Title',
    displayName: 'Placeholder',
  );

  final maxLengthControl = PreviewControl.integer(
    defaultValue: 40,
    displayName: 'Max Length',
    minValue: 1,
    maxValue: 100,
  );

  @override
  String get displayName => 'Text Field · Title';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final status = statusControl.of(context);
    final placeholder = placeholderControl.of(context);
    final maxLength = maxLengthControl.of(context);

    return GdsTextField.title(
      size: size.value,
      status: status.value,
      placeholder: placeholder.mayBeValue,
      maxLength: maxLength.value,
    );
  }
}
