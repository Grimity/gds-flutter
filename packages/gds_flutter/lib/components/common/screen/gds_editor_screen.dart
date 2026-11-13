// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 편집 화면에 표시할 본문과 제출 버튼을 정의하는 구성.
class GdsEditorContent({
  required final GdsTextButtonAction submitButton,
  required final Widget child,
});

/// 편집할 본문과 제출 버튼을 모바일에서는 페이지, 태블릿에서는 모달로 표시하는 화면.
abstract class GdsEditorScreen extends GdsScreen<GdsEditorContent> {
  const new();

  /// 페이지의 앱바 또는 모달의 헤더에 표시할 제목.
  String get title;

  /// 본문에 스크롤을 적용할지 여부.
  bool get scroll;

  @override
  Widget buildPage(BuildContext context) {
    final content = build(context);
    final action = content.submitButton;

    return GdsScaffold(
      appBar: GdsTopNavigation.editor(
        onBack: context.pop,
        title: title,
        action: .new(
          type: .borderless,
          variant: .primary,
          enabled: action.enabled,
          label: action.label,
          onTap: action.onTap,
        ),
        onMenu: null,
      ),
      body: GdsScrollable(
        enabled: scroll,
        padding: .all(16),
        child: content.child,
      ),
    );
  }

  @override
  GdsModal buildModal(BuildContext context) {
    final content = build(context);

    return .new(
      title: title,
      onBack: context.pop,
      scroll: scroll,
      primaryButton: content.submitButton,
      child: content.child,
    );
  }
}
