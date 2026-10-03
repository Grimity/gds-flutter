import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsProfileEdit]에 대한 프리뷰 위젯.
class GdsProfileEditPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .xl,
    displayName: 'Size',
    values: const [.ml, .xl],
  );

  final urlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Image URL',
  );

  @override
  String get displayName => 'Profile Edit';

  @override
  List<String> get groups => ['Avatar'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final url = urlControl.of(context);

    return GdsProfileEdit(
      size: size.value,
      image: url.mayBeValue?.networkImage,
      onTap: () => debugPrint('onTap() called'),
    );
  }
}
