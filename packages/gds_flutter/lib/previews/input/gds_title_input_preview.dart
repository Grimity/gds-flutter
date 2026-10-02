import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsInput.title]에 대한 프리뷰 위젯.
class GdsTitleInputPreview extends PreviewWidget {
  final titleControl = PreviewControl.string(
    initialValue: 'Title',
    displayName: 'Title',
  );

  final helperTextControl = PreviewControl.string(
    initialValue: 'Helper text',
    displayName: 'Helper Text',
  );

  final helperStatusControl = PreviewControl.select<GdsHelperTextStatus>(
    defaultValue: .enabled,
    displayName: 'Helper Status',
    values: GdsHelperTextStatus.values,
  );

  final requiredControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Required',
  );

  final showButtonControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Button',
  );

  @override
  String get displayName => 'Input · Title';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final helperText = helperTextControl.of(context);
    final helperStatus = helperStatusControl.of(context);
    final required = requiredControl.of(context);
    final showButton = showButtonControl.of(context);

    createButtonAction() => GdsTextButtonAction(
      onTap: () => debugPrint("onTap() called"),
      label: 'Label',
    );

    return GdsInput.title(
      title: title.mayBeValue,
      helperText: helperText.mayBeValue,
      helperStatus: helperStatus.value,
      required: required.value,
      field: GdsInputAction(placeholder: 'Placeholder'),
      button: showButton.value ? createButtonAction() : null,
    );
  }
}
