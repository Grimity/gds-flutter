// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 적응형 화면에 표시할 본문과 앱바를 정의하는 구성.
class GdsBasicContent({
  required final Widget? appBar,
  required final Widget child,
});

/// 본문과 앱바를 모바일에서는 페이지, 태블릿에서는 모달로 표시하는 화면.
abstract class GdsBasicScreen extends GdsScreen<GdsBasicContent> {
  const new();

  @override
  Widget buildPage(BuildContext context) {
    final content = build(context);

    return GdsScaffold(
      appBar: content.appBar,
      body: GdsScrollable(
        enabled: scroll,
        padding: padding ?? .all(16),
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
      padding: padding ?? GdsModal.defaultPadding,
      child: content.child,
    );
  }
}
