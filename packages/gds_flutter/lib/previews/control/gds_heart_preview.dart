import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsHeart]에 대한 프리뷰 위젯.
class GdsHeartPreview extends PreviewWidget {
  final valueControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Value',
  );

  final blackControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Black',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  @override
  String get displayName => 'Heart';

  @override
  List<String> get groups => ['Control'];

  @override
  Widget build(BuildContext context) {
    final value = valueControl.of(context);
    return GdsHeart(
      value: value.value,
      black: blackControl.of(context).value,
      enabled: enabledControl.of(context).value,
      onChanged: (newValue) => value.value = newValue,
    );
  }
}
