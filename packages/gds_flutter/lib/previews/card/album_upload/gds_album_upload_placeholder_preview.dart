import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsAlbumUpload.placeholder]에 대한 프리뷰 위젯.
class GdsAlbumUploadPlaceholderPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .lg,
    displayName: 'Size',
    values: const [.lg, .md],
  );

  @override
  String get displayName => 'Placeholder';

  @override
  List<String> get groups => ['Card', 'Album Upload'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);

    return GdsAlbumUpload.placeholder(
      size: size.value,
      onTap: () => debugPrint('onTap() called'),
    );
  }
}
