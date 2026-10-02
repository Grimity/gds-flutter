import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTextField.normal]에 대한 프리뷰 위젯.
class GdsNormalTextFieldPreview extends PreviewWidget {
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

  final prefixTextControl = PreviewControl.string(
    displayName: 'Prefix Text',
  );

  final mentionTextControl = PreviewControl.string(
    displayName: 'Mention Text',
  );

  final obscureTextControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Obscure Text',
  );

  final placeholderControl = PreviewControl.string(
    initialValue: 'Placeholder',
    displayName: 'Placeholder',
  );

  final maxLengthControl = PreviewControl.integer(
    initialValue: 20,
    displayName: 'Max Length',
    minValue: 1,
    maxValue: 100,
  );

  @override
  String get displayName => 'Text Field · Normal';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final status = statusControl.of(context);
    final prefixText = prefixTextControl.of(context);
    final mentionText = mentionTextControl.of(context);
    final obscureText = obscureTextControl.of(context);
    final placeholder = placeholderControl.of(context);
    final maxLength = maxLengthControl.of(context);

    return GdsTextField.normal(
      size: size.value,
      status: status.value,
      prefixText: prefixText.mayBeValue,
      mentionText: mentionText.mayBeValue,
      obscureText: obscureText.value,
      placeholder: placeholder.mayBeValue,
      maxLength: maxLength.mayBeValue,
    );
  }
}
