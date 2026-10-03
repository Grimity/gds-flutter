import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUser.tagView]에 대한 프리뷰 위젯.
class GdsUserTagViewPreview extends PreviewWidget {
  final contentControl = PreviewControl.string(
    defaultValue: '태그 내용',
    displayName: 'Content',
  );

  final thumbnailUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Thumbnail URL',
  );

  @override
  String get displayName => 'Tag View';

  @override
  List<String> get groups => ['Card', 'User'];

  @override
  Widget build(BuildContext context) {
    final content = contentControl.of(context);
    final thumbnailUrl = thumbnailUrlControl.of(context);

    return GdsUser.tagView(
      content: content.value,
      thumbnail: thumbnailUrl.mayBeValue?.networkImage,
    );
  }
}
