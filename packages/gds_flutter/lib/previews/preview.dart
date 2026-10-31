// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter_design_preview/flutter_design_preview.dart';

/// 프리뷰에서 공통으로 사용하는 프로필 이미지 URL.
const String previewProfileUrl = 'https://avatars.githubusercontent.com/u/122026021';

/// 프리뷰에서 스켈레톤 표시 여부를 전환하는 공통 컨트롤.
final showSkeletonControl = PreviewControl.boolean(
  defaultValue: false,
  displayName: 'Show Skeleton',
);
