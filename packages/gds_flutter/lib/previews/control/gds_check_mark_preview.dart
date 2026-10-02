import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsCheckMark]에 대한 프리뷰 위젯.
class GdsCheckMarkPreview extends PreviewWidget {
  final valueControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Value',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  @override
  String get displayName => 'Check Mark';

  @override
  List<String> get groups => ['Control'];

  @override
  Widget build(BuildContext context) {
    final value = valueControl.of(context);
    return GdsCheckMark(
      value: value.value,
      enabled: enabledControl.of(context).value,
      onChanged: (newValue) => value.value = newValue,
    );
  }
}
