// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 적응형 화면에 표시할 본문과 액션 버튼을 정의하는 구성.
class GdsActionContent({
  final GdsTextButtonAction? primaryButton,
  final GdsTextButtonAction? secondaryButton,
  required final Widget child,
});

/// 본문과 하단 액션 버튼을 모바일에서는 페이지, 태블릿에서는 모달로 표시하는 화면.
abstract class GdsActionScreen extends GdsScreen<GdsActionContent> {
  const new();

  /// 페이지의 앱바 또는 모달의 헤더에 표시할 제목.
  String get title;

  /// 본문에 스크롤을 적용할지 여부.
  bool get scroll;

  @override
  Widget buildPage(BuildContext context) {
    final content = build(context);

    return GdsScaffold(
      appBar: GdsTopNavigation.iconButton(
        onBack: context.pop,
        title: title,
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: GdsScrollable(
              enabled: scroll,
              padding: .all(16),
              child: content.child,
            ),
          ),
          Padding(
            padding: .only(top: 8, bottom: 24, left: 16, right: 16),
            child: Row(
              spacing: 8,
              children: [
                // 보조 버튼 표시
                if (content.secondaryButton case final action?) ...[
                  Expanded(
                    child: GdsButton.text(
                      type: .outlined,
                      size: .lg,
                      label: action.label,
                      onTap: action.onTap,
                      enabled: action.enabled,
                      layerLink: action.layerLink,
                      mainAxisSize: .max,
                    ),
                  ),
                ],

                // 주 버튼 표시
                if (content.primaryButton case final action?) ...[
                  Expanded(
                    child: GdsButton.text(
                      type: .solid,
                      size: .lg,
                      label: action.label,
                      onTap: action.onTap,
                      enabled: action.enabled,
                      layerLink: action.layerLink,
                      mainAxisSize: .max,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
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
      primaryButton: content.primaryButton,
      secondaryButton: content.secondaryButton,
      child: content.child,
    );
  }
}
