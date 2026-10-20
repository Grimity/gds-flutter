import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

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
    required GdsAdaptiveModal Function(BuildContext context) builder,
  }) {
    if (context.isMobile) {
      // 모바일에서는 바텀 시트로 표시.
      return GdsBottomSheet.show<T>(
        context,
        builder: (context) {
          final modal = builder(context);

          return GdsBottomSheet(
            onBack: context.pop,
            title: modal.title,
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
          onBack: context.pop,
          title: modal.title,
          primaryButton: modal.primaryButton,
          secondaryButton: modal.secondaryButton,
          child: modal,
        );
      },
    );
  }
}
