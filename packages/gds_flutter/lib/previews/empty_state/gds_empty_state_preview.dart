import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsEmptyState]에 대한 프리뷰 위젯.
class GdsEmptyStatePreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .xl,
    displayName: 'Size',
    values: const [.xl, .md],
  );

  final titleControl = PreviewControl.string(
    defaultValue: '제목',
    displayName: 'Title',
  );

  final descriptionControl = PreviewControl.string(
    initialValue: '상황에 대한 설명이 들어가요.\n설명은 최대 2줄까지만 작성해요.',
    displayName: 'Description',
  );

  final showButtonControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Button',
  );

  final buttonTypeControl = PreviewControl.select<GdsTextButtonType>(
    defaultValue: .solid,
    displayName: 'Button Type',
    values: GdsTextButtonType.values,
  );

  @override
  String get displayName => 'Empty State';

  @override
  List<String> get groups => ['Empty State'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final title = titleControl.of(context);
    final description = descriptionControl.of(context);
    final showButton = showButtonControl.of(context);
    final buttonType = buttonTypeControl.of(context);

    // 액션 버튼.
    final button = GdsTextButtonAction(
      label: 'Label',
      onTap: () => debugPrint('GdsEmptyState.button.onTap() called'),
    );

    return GdsEmptyState(
      size: size.value,
      illust: .resultNull,
      title: title.value,
      description: description.mayBeValue,
      button: showButton.value ? button : null,
      buttonType: buttonType.value,
    );
  }
}
