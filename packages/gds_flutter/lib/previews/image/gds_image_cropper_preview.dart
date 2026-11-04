// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsImageCropper]에 대한 프리뷰 위젯.
class GdsImageCropperPreview extends PreviewWidget {
  final shapeControl = PreviewControl.select<BoxShape>(
    defaultValue: .rectangle,
    displayName: 'Shape',
    values: BoxShape.values,
  );

  final imageUrlControl = PreviewControl.string(
    defaultValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  final aspectRatioControl = PreviewControl.select<GdsThumbnailRatio>(
    defaultValue: .square,
    displayName: 'Aspect Ratio',
    values: GdsThumbnailRatio.values,
  );

  @override
  String get displayName => 'Cropper';

  @override
  List<String> get groups => ['Image'];

  @override
  Widget build(BuildContext context) {
    final controller = context.useCustomImageCropController();

    final shape = shapeControl.of(context);
    final imageUrl = imageUrlControl.of(context);
    final aspectRatio = aspectRatioControl.of(context);

    return GdsImageCropper(
      shape: shape.value,
      aspectRatio: aspectRatio.value.value,
      controller: controller,
      provider: NetworkImage(imageUrl.value),
    );
  }
}
