import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsModal] preview widget.
class GdsModalPreview extends PreviewWidget {
  final titleControl = PreviewControl.string(
    defaultValue: '제목',
    displayName: 'Title',
  );

  final showActionControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Action',
  );

  final showPrimaryButtonControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Primary Button',
  );

  final showSecondaryButtonControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Secondary Button',
  );

  @override
  String get displayName => 'Modal';

  @override
  List<String> get groups => ['Popup'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final showAction = showActionControl.of(context);
    final showPrimaryButton = showPrimaryButtonControl.of(context);
    final showSecondaryButton = showSecondaryButtonControl.of(context);

    // 아이콘 액션 버튼.
    final iconAction = GdsIconButtonAction(
      icon: .blank,
      onTap: () => debugPrint('GdsModal.action.onTap() called'),
    );

    final primaryButton = GdsTextButtonAction(
      label: '제출하기',
      onTap: () => debugPrint('GdsModal.primaryButton.onTap() called'),
    );

    final secondaryButton = GdsTextButtonAction(
      label: '취소',
      onTap: () => debugPrint('GdsModal.secondaryButton.onTap() called'),
    );

    return GdsModal(
      title: title.value,
      onBack: () => debugPrint('GdsModal.onBack() called'),
      iconAction: showAction.value ? iconAction : null,
      primaryButton: showPrimaryButton.value ? primaryButton : null,
      secondaryButton: showSecondaryButton.value ? secondaryButton : null,
      child: const GdsText(
        'Hello, World!',
        color: .textGrayNormal,
        style: .body1R,
      ),
    );
  }
}
