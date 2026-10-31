// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

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

  final openControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Open',
  );

  @override
  String get displayName => 'Editor';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final label = labelControl.of(context);
    final open = openControl.of(context);

    return GdsTopNavigation.editor(
      onBack: () => debugPrint('onBack() called'),
      onTitle: () => debugPrint('onTitle() called'),
      action: .new(
        label: label.value,
        onTap: () => debugPrint('action.onTap() called'),
      ),
      title: title.value,
      open: open.value,
    );
  }
}
