// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsExpandableText]에 대한 프리뷰 위젯.
class GdsChipPreview extends PreviewWidget {
  final maxLinesControl = PreviewControl.integer(
    defaultValue: 2,
    displayName: 'Max Lines',
  );

  @override
  String get displayName => 'Expandable Text';

  @override
  List<String> get groups => ['Common'];

  @override
  Widget build(BuildContext context) {
    final maxLines = maxLinesControl.of(context);

    return GdsExpandableText(
      '안녕하세요 일러스트레이터로 활동중인 체리마루입니다. :D\n'
      '그간 작업했던 팬아트, 외주 등등 올려봅니다.\n'
      '​아래로 갈수록 최신순 입니다!',
      style: .body1R,
      color: .textGrayBold,
      maxLines: maxLines.value,
    );
  }
}
