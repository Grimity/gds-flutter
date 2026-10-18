import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsFilter]에 대한 프리뷰 위젯.
class GdsFilterPreview extends PreviewWidget {
  final variantControl = PreviewControl.select<GdsFilterVariant>(
    defaultValue: .outline,
    displayName: 'Variant',
    values: GdsFilterVariant.values,
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  @override
  String get displayName => 'Filter';

  @override
  List<String> get groups => ['Filter'];

  @override
  Widget build(BuildContext context) {
    final variant = variantControl.of(context);
    final label = labelControl.of(context);
    final enabled = enabledControl.of(context);

    return GdsFilter(
      variant: variant.value,
      label: label.value,
      enabled: enabled.value,
      onTap: () async {
        debugPrint('onTap() called');

        await Future.delayed(.new(seconds: 1));
      },
    );
  }
}
