// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsEditorField]에 대한 프리뷰 위젯.
class GdsEditorFieldPreview extends PreviewWidget {
  @override
  String get displayName => 'Editor Field';

  @override
  List<String> get groups => ['Editor'];

  @override
  Widget build(BuildContext context) {
    final controller = context.useQuillController();

    return GdsEditorField(
      controller: controller,
      maxCount: 500,
      placeholder: '내용을 입력하세요',
    );
  }
}
