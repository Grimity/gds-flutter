// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// 이미지 URL에 해당하는 위젯을 반환하는 빌더.
typedef ImageBuilder = Widget Function(BuildContext context, String url);

/// 이미지 임베드를 외부에서 전달한 위젯 빌더에 연결하는 빌더.
class ImageEmbedBuilder extends EmbedBuilder {
  const new(this.builder);

  final ImageBuilder builder;

  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    return builder(context, embedContext.node.value.data as String);
  }
}
