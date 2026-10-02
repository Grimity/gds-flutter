import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsCheckBox]에 대한 프리뷰 위젯.
class GdsCheckBoxPreview extends PreviewWidget {
  final valueControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Value',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.md, .sm],
  );

  @override
  String get displayName => 'Check Box';

  @override
  List<String> get groups => ['Control'];

  @override
  Widget build(BuildContext context) {
    final value = valueControl.of(context);
    return GdsCheckBox(
      size: sizeControl.of(context).value,
      value: value.value,
      enabled: enabledControl.of(context).value,
      onChanged: (newValue) => value.value = newValue,
    );
  }
}
