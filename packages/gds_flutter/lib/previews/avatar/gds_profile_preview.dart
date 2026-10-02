import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsProfile]에 대한 프리뷰 위젯.
class GdsProfilePreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .lg,
    displayName: 'Size',
    values: GdsSize.values,
  );

  final urlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  @override
  String get displayName => 'Profile';

  @override
  List<String> get groups => ['Avatar'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final url = urlControl.of(context);

    return GdsProfile(size: size.value, url: url.mayBeValue);
  }
}
