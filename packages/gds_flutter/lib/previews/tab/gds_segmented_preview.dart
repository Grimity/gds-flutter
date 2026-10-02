import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsSegmented]에 대한 프리뷰 위젯.
class GdsSegmentedPreview extends PreviewWidget {
  final indexControl = PreviewControl.integer(
    defaultValue: 0,
    displayName: 'Index',
    minValue: 0,
    maxValue: 2,
  );

  @override
  String get displayName => 'Segmented';

  @override
  List<String> get groups => ['Tab'];

  @override
  Widget build(BuildContext context) {
    final index = indexControl.of(context);

    return GdsSegmented(
      index: index.value,
      items: const ['Option 1', 'Option 2', 'Option 3'],
      onChanged: (newIndex) => index.value = newIndex,
    );
  }
}
