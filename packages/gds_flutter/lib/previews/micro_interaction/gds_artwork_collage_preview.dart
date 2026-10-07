import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsArtworkCollage]에 대한 프리뷰 위젯.
class GdsArtworkCollagePreview extends PreviewWidget {
  final velocityControl = PreviewControl.double(
    defaultValue: 5,
    displayName: 'Velocity',
    minValue: 1,
    maxValue: 100,
  );

  final scaleControl = PreviewControl.double(
    defaultValue: 1.15,
    displayName: 'Scale',
    minValue: 1,
    maxValue: 2,
  );

  @override
  String get displayName => 'Artwork Collage';

  @override
  List<String> get groups => ['Micro Interaction'];

  @override
  Widget build(BuildContext context) {
    final velocity = velocityControl.of(context);
    final scale = scaleControl.of(context);

    return GdsArtworkCollage(
      velocity: velocity.value,
      scale: scale.value,
    );
  }
}
