// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 적응형 화면에 표시할 본문과 액션 버튼을 정의하는 구성.
class GdsAdaptiveContent({
  final GdsTextButtonAction? primaryButton,
  final GdsTextButtonAction? secondaryButton,
  required final Widget child,
});

/// 모바일에서는 페이지, 태블릿에서는 모달로 표시할 화면을 정의하는 위젯.
abstract class GdsAdaptivePage {
  const new();

  /// 페이지의 앱바 또는 모달의 헤더에 표시할 제목.
  String get title;

  /// 화면에 표시할 본문과 액션 버튼을 구성합니다.
  GdsAdaptiveContent build(BuildContext context);

  /// 제목, 본문과 하단 액션 버튼을 갖춘 페이지를 구성합니다.
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
            child: SingleChildScrollView(
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

  /// 제목, 본문과 액션 버튼을 갖춘 모달을 구성합니다.
  GdsModal buildModal(BuildContext context) {
    final content = build(context);

    return .new(
      onBack: context.pop,
      primaryButton: content.primaryButton,
      secondaryButton: content.secondaryButton,
      title: title,
      child: content.child,
    );
  }

  /// 모바일에서는 페이지로 이동하고, 태블릿에서는 모달을 엽니다.
  Future<T?> push<T>(BuildContext context) {
    if (context.isMobile) {
      return context.push(Builder(builder: buildPage));
    } else {
      return GdsModal.show(context, builder: buildModal);
    }
  }

  /// 모바일에서는 페이지를 교체하고, 태블릿에서는 페이지를 닫고 동시에 모달을 엽니다.
  Future<T?> pushReplacement<T>(BuildContext context) {
    if (context.isMobile) {
      return context.pushReplacement(Builder(builder: buildPage));
    } else {
      context.pop();
      return GdsModal.show(context, builder: buildModal);
    }
  }
}
