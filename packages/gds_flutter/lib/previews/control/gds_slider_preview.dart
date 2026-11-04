// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsSlider]에 대한 프리뷰 위젯.
class GdsSliderPreview extends PreviewWidget {
  final minControl = PreviewControl.double(
    defaultValue: 0,
    displayName: 'Min',
  );

  final maxControl = PreviewControl.double(
    defaultValue: 1,
    displayName: 'Max',
  );

  final valueControl = PreviewControl.double(
    defaultValue: 0,
    displayName: 'Value',
  );

  @override
  String get displayName => 'Slider';

  @override
  List<String> get groups => ['Control'];

  @override
  Widget build(BuildContext context) {
    final min = minControl.of(context);
    final max = maxControl.of(context);
    final value = valueControl.of(context);

    return GdsSlider(
      min: min.value,
      max: max.value,
      value: value.value,
      onChanged: (newValue) {
        debugPrint('GdsSlider.onChanged() called with $newValue');
        value.value = newValue;
      },
    );
  }
}
