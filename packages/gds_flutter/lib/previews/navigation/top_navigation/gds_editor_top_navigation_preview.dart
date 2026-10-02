import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTopNavigation.editor]에 대한 프리뷰 위젯.
class GdsEditorTopNavigationPreview extends PreviewWidget {
  final titleControl = PreviewControl.string(
    defaultValue: 'Title',
    displayName: 'Title',
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  @override
  String get displayName => 'Editor';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final label = labelControl.of(context);

    return GdsTopNavigation.editor(
      onBack: () => debugPrint('onBack() called'),
      onTitle: () => debugPrint('onTitle() called'),
      onAction: () => debugPrint('onAction() called'),
      title: title.value,
      label: label.value,
    );
  }
}
