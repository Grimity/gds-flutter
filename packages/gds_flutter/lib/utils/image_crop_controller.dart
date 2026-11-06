// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/widgets.dart';

/// 이미지 변환 후 실제 배율의 변경을 알리는 크롭 컨트롤러.
class ImageCropController extends CustomImageCropController {
  final scale = ValueNotifier<double>(1);

  @override
  void addTransition(CropImageData transition) {
    super.addTransition(transition);
    scale.value = cropImageData!.scale;
  }

  @override
  void setData(CropImageData data) {
    super.setData(data);
    scale.value = cropImageData!.scale;
  }

  @override
  void dispose() {
    scale.dispose();
    super.dispose();
  }
}
