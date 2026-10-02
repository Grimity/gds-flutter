import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsRadio]에 대한 프리뷰 위젯.
class GdsRadioPreview extends PreviewWidget {
  final valueControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Value',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  @override
  String get displayName => 'Radio';

  @override
  List<String> get groups => ['Control'];

  @override
  Widget build(BuildContext context) {
    final value = valueControl.of(context);
    return GdsRadio(
      value: value.value,
      enabled: enabledControl.of(context).value,
      onChanged: (newValue) => value.value = newValue,
    );
  }
}
