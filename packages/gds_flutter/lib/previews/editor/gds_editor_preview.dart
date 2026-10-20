import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsEditor]에 대한 프리뷰 위젯.
class GdsEditorPreview extends PreviewWidget {
  @override
  String get displayName => 'Editor';

  @override
  List<String> get groups => ['Editor'];

  @override
  Widget build(BuildContext context) {
    final controller = context.useQuillController();

    return GdsEditor(
      controller: controller,
      maxCount: 500,
      onAddImage: () async => previewProfileUrl,
      onAddLink: () async => (
        name: '링크 확인하기',
        url: 'https://example.com',
      ),
    );
  }
}
