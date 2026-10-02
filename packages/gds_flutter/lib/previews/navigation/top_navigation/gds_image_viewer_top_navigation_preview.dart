import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTopNavigation.imageViewer]에 대한 프리뷰 위젯.
class GdsImageViewerTopNavigationPreview extends PreviewWidget {
  final canDownloadControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Can Download',
  );

  @override
  String get displayName => 'Image Viewer';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final canDownload = canDownloadControl.of(context);

    return GdsTopNavigation.imageViewer(
      onBack: () => debugPrint('onBack() called'),
      onDownload: () => debugPrint('onDownload() called'),
      canDownload: canDownload.value,
    );
  }
}
