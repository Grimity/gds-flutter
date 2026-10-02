import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsAlbumUpload.album]에 대한 프리뷰 위젯.
class GdsAlbumUploadAlbumPreview extends PreviewWidget {
  final imageControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  final countControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Count',
  );

  final checkedControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Checked',
  );

  @override
  String get displayName => 'Album';

  @override
  List<String> get groups => ['Card', 'Album Upload'];

  @override
  Widget build(BuildContext context) {
    final image = imageControl.of(context);
    final count = countControl.of(context);
    final checked = checkedControl.of(context);

    return GdsAlbumUpload.album(
      image: image.value.networkImage,
      count: count.value,
      checked: checked.value,
      onTap: () => debugPrint('onTap() called'),
    );
  }
}
