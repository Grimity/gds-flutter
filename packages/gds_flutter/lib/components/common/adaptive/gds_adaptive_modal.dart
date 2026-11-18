// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsAdaptiveModal]를 반환하는 빌더.
typedef GdsAdaptiveModalBuilder = GdsAdaptiveModal Function(BuildContext context);

/// 모바일에서는 바텀 시트, 태블릿에서는 모달 팝업으로 콘텐츠를 표시하는 위젯.
class GdsAdaptiveModal extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    this.primaryButton,
    this.secondaryButton,
    this.spacing = 8,
    required this.children,
  });

  final String title;
  final GdsTextButtonAction? primaryButton;
  final GdsTextButtonAction? secondaryButton;
  final GdsSpacing spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      spacing: spacing,
      children: children,
    );
  }

  /// 모바일에서는 바텀 시트, 태블릿에서는 모달 팝업으로 엽니다.
  static Future<T?> show<T>(
    BuildContext context, {
    required GdsAdaptiveModalBuilder builder,
  }) {
    // 모바일에서는 바텀 시트로 표시.
    if (context.isMobile) {
      return GdsBottomSheet.show<T>(
        context,
        builder: (context) {
          final modal = builder(context);

          return GdsBottomSheet(
            title: modal.title,
            onBack: context.pop,
            primaryButton: modal.primaryButton,
            secondaryButton: modal.secondaryButton,
            child: modal,
          );
        },
      );
    }

    // 태블릿에서는 모달 팝업으로 표시.
    return GdsModal.show<T>(
      context,
      builder: (context) {
        final modal = builder(context);

        return GdsModal(
          title: modal.title,
          onBack: context.pop,
          primaryButton: modal.primaryButton,
          secondaryButton: modal.secondaryButton,
          child: modal,
        );
      },
    );
  }
}
