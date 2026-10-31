// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsInput.community]에 대한 프리뷰 위젯.
class GdsCommunityInputPreview extends PreviewWidget {
  final mentionTextControl = PreviewControl.string(
    displayName: 'Mention Text',
  );

  @override
  String get displayName => 'Input · Community';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final mentionText = mentionTextControl.of(context);

    return GdsInput.community(
      mentionText: mentionText.mayBeValue,
      field: .new(placeholder: '댓글 입력'),
      button: .new(
        onTap: () => debugPrint('onTap() called'),
        label: '등록',
      ),
    );
  }
}
