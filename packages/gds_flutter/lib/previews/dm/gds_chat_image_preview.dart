import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsChatImages]에 대한 프리뷰 위젯.
class GdsChatImagePreview extends PreviewWidget {
  final imageCountControl = PreviewControl.integer(
    defaultValue: 3,
    displayName: 'Image Count',
    minValue: 1,
    maxValue: 9,
  );

  final imageUrlControl = PreviewControl.string(
    defaultValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  @override
  String get displayName => 'Chat Image';

  @override
  List<String> get groups => ['DM'];

  @override
  Widget build(BuildContext context) {
    final imageCount = imageCountControl.of(context);
    final imageUrl = imageUrlControl.of(context);
    final images = List.generate(
      imageCount.value,
      (_) => NetworkImage(imageUrl.value),
    );

    return GdsChatImages(
      images: images,
      onTap: (image) => debugPrint('onTap() called: $image'),
    );
  }
}
