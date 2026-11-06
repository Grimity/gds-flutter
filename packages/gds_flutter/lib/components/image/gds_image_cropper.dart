import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 이미지를 확대 및 축소하고 이동하여 지정한 모양과 비율로 자를 수 있는 위젯.
class GdsImageCropper extends StatelessWidget {
  const new({
    super.key,
    this.aspectRatio = 1,
    this.radius = .none,
    required this.shape,
    required this.provider,
    required this.controller,
  });

  final double aspectRatio;
  final GdsRadius radius;
  final BoxShape shape;
  final ImageProvider provider;
  final CustomImageCropController controller;

  @override
  Widget build(BuildContext context) {
    assert(shape != .circle || aspectRatio == 1);

    return CustomImageCrop(
      cropController: controller,
      forceInsideCropArea: true,
      canMove: true,
      canScale: true,
      canRotate: false,
      cropPercentage: 1.0,
      ratio: .new(width: aspectRatio, height: 1),
      shape: shape == .circle ? .Circle : .Ratio,
      image: provider,
      overlayColor: GdsAtomicColor.black.opacity60,
      backgroundColor: GdsAtomicColor.transparent,
      borderRadius: radius.value,
      customProgressIndicator: const GdsCircularLoading(),
      drawPath: SolidCropPathPainter.drawPath,
      outlineColor: GdsAtomicColor.white,
      outlineStrokeWidth: 2,
    );
  }
}
