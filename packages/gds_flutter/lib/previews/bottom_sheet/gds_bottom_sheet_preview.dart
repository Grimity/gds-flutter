import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsBottomSheet]에 대한 프리뷰 위젯.
class GdsBottomSheetPreview extends PreviewWidget {
  final titleControl = PreviewControl.string(
    initialValue: '제목',
    displayName: 'Title',
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
  String get displayName => 'Bottom Sheet';

  @override
  List<String> get groups => ['Bottom Sheet'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final showPrimaryButton = showPrimaryButtonControl.of(context);
    final showSecondaryButton = showSecondaryButtonControl.of(context);

    // 주 버튼
    final primaryButton = GdsTextButtonAction(
      label: '제출하기',
      onTap: () => debugPrint('GdsBottomSheet.primaryButton.onTap() called'),
    );

    // 보조 버튼
    final secondaryButton = GdsTextButtonAction(
      label: '취소',
      onTap: () => debugPrint('GdsBottomSheet.secondaryButton.onTap() called'),
    );

    return GdsBottomSheet(
      title: title.mayBeValue,
      onBack: () => debugPrint('GdsBottomSheet.onBack() called'),
      primaryButton: showPrimaryButton.value ? primaryButton : null,
      secondaryButton: showSecondaryButton.value ? secondaryButton : null,
      child: const GdsText(
        '바덤 시트의 내용이 여기에 표시됩니다.',
        color: .textGrayNormal,
        style: .body2R,
      ),
    );
  }
}
