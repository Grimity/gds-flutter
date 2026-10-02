import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsThumbnail]에 대한 프리뷰 위젯.
class GdsThumbnailPreview extends PreviewWidget {
  final ratioControl = PreviewControl.select<GdsThumbnailRatio>(
    defaultValue: .square,
    displayName: 'Ratio',
    values: GdsThumbnailRatio.values,
  );

  final widthControl = PreviewControl.double(
    defaultValue: 240,
    displayName: 'Width',
    minValue: 80,
    maxValue: 400,
  );

  final fitControl = PreviewControl.select<BoxFit>(
    defaultValue: .cover,
    displayName: 'BoxFit',
    values: BoxFit.values,
  );

  final urlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  @override
  String get displayName => 'Thumbnail';

  @override
  List<String> get groups => ['Thumbnail'];

  @override
  Widget build(BuildContext context) {
    final ratio = ratioControl.of(context);
    final width = widthControl.of(context);
    final fit = fitControl.of(context);
    final url = urlControl.of(context);

    return SizedBox(
      width: width.value,
      child: GdsThumbnail(
        fit: fit.value,
        ratio: ratio.value,
        provider: url.mayBeValue != null ? NetworkImage(url.value) : null,
      ),
    );
  }
}
