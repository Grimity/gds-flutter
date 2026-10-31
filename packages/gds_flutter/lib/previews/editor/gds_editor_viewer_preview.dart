// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsEditorViewer]에 대한 프리뷰 위젯.
class GdsEditorViewerPreview extends PreviewWidget {
  @override
  String get displayName => 'Editor Viewer';

  @override
  List<String> get groups => ['Editor'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GdsEditorViewer(
        html:
            '''
          <h1>제목1 스타일</h1>
          <h2>제목2 스타일</h2>
          <p>본문 스타일</p>
          <p>기기 유형에 맞는 기본 본문 스타일입니다.</p>
          <p><strong>굵게</strong>, <em>기울이기</em>, <u>밑줄</u>, <s>취소선</s></p>
          <p><span style="color: #FF0000">글자색</span>과
          <span style="background-color: #FFFF00">글자 배경색</span></p>
          <p><a href="https://example.com">링크 확인하기</a></p>
          <img src="$previewProfileUrl">
        ''',
        imageBuilder: (context, url) {
          return GdsImage(
            provider: NetworkImage(url),
            height: 200,
            fit: .contain,
          );
        },
        onLinkTap: (url) {
          debugPrint('GdsEditorViewer.onLinkTap($url) called');
        },
      ),
    );
  }
}
