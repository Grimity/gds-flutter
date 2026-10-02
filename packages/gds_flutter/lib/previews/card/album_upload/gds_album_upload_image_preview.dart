import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsAlbumUpload.image]에 대한 프리뷰 위젯.
class GdsAlbumUploadImagePreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .lg,
    displayName: 'Size',
    values: const [.lg, .md],
  );

  final imageControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  final titleControl = PreviewControl.string(
    defaultValue: 'Main title is here',
    displayName: 'Title',
  );

  final checkedControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Checked',
  );

  @override
  String get displayName => 'Image';

  @override
  List<String> get groups => ['Card', 'Album Upload'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final image = imageControl.of(context);
    final title = titleControl.of(context);
    final checked = checkedControl.of(context);

    return GdsAlbumUpload.image(
      size: size.value,
      image: image.value.networkImage,
      title: title.value,
      checked: checked.value,
      onTap: () => debugPrint('onTap() called'),
      onRemove: () => debugPrint('onRemove() called'),
    );
  }
}
