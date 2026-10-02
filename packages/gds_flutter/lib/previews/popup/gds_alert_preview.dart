import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsAlert]에 대한 프리뷰 위젯.
class GdsAlertPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.xl, .md],
  );

  final titleControl = PreviewControl.string(
    defaultValue: '제목',
    displayName: 'Title',
  );

  final descriptionControl = PreviewControl.string(
    defaultValue: '상황에 대한 설명이 들어가요.\n설명은 최대 2줄까지만 작성해요.',
    displayName: 'Description',
  );

  final showIllustControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Illustration',
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
  String get displayName => 'Alert';

  @override
  List<String> get groups => ['Popup'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final title = titleControl.of(context);
    final description = descriptionControl.of(context);
    final showIllust = showIllustControl.of(context);
    final showPrimaryButton = showPrimaryButtonControl.of(context);
    final showSecondaryButton = showSecondaryButtonControl.of(context);

    // 주 버튼.
    final primaryButton = GdsTextButtonAction(
      label: '제출하기',
      onTap: () => debugPrint('GdsAlert.primaryButton.onTap() called'),
    );

    // 보조 버튼.
    final secondaryButton = GdsTextButtonAction(
      label: '취소',
      onTap: () => debugPrint('GdsAlert.secondaryButton.onTap() called'),
    );

    return GdsAlert(
      size: size.value,
      title: title.value,
      description: description.value,
      illust: showIllust.value ? .success : null,
      primaryButton: showPrimaryButton.value ? primaryButton : null,
      secondaryButton: showSecondaryButton.value ? secondaryButton : null,
    );
  }
}
