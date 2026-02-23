import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsInput, path: '[component]/[input]')
Widget buildGdsInputUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Input',
    description:
        'TextField + Title + HelperText를 조합한 입력 컴포넌트입니다.\n'
        'Default / Button / Community / CommunityAnswer 네 가지 타입을 제공합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<_InputType>(
    label: 'type',
    options: _InputType.values,
    labelBuilder: (t) => t.name,
  );

  final placeholder = context.knobs.stringOrNull(label: 'placeholder', initialValue: 'Input filled');
  final titleText = context.knobs.stringOrNull(label: 'titleText', initialValue: 'Title');
  final isRequired = context.knobs.boolean(label: 'isRequired', initialValue: true);
  final helperText = context.knobs.stringOrNull(label: 'helperText', initialValue: 'Helper text');
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final error = context.knobs.boolean(label: 'error', initialValue: false);
  final success = context.knobs.boolean(label: 'success', initialValue: false);

  final bool isDefaultOrButton = type == _InputType.defaultField || type == _InputType.button;

  final Widget input = switch (type) {
    _InputType.defaultField => GdsInput(
      placeholder: placeholder,
      titleText: titleText,
      isRequired: isRequired,
      helperText: helperText,
      enabled: enabled,
      error: error,
      success: success,
    ),
    _InputType.button => GdsInput.button(
      buttonLabel: 'label',
      placeholder: placeholder,
      titleText: titleText,
      isRequired: isRequired,
      helperText: helperText,
      enabled: enabled,
      error: error,
      success: success,
    ),
    _InputType.community => GdsInput.community(
      placeholder: placeholder ?? '댓글 입력',
    ),
    _InputType.communityAnswer => GdsInput.communityAnswer(
      replyUser: 'user',
      placeholder: placeholder,
      mentionUser: 'user',
    ),
  };

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      if (isDefaultOrButton) 'titleText: $titleText',
      if (isDefaultOrButton) 'isRequired: $isRequired',
      if (isDefaultOrButton) 'helperText: $helperText',
      if (isDefaultOrButton) 'enabled: $enabled',
      if (isDefaultOrButton) 'error: $error',
      if (isDefaultOrButton) 'success: $success',
    ],
    child: SizedBox(width: 335, child: input),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Input',
    children: [
      WidgetbookSubsection(
        title: 'type',
        labels: ['4 types'],
        content: const _InputMatrix(),
      ),
    ],
  );
}

enum _InputType { defaultField, button, community, communityAnswer }

class _InputMatrix extends StatelessWidget {
  const _InputMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    const rows = [
      (label: 'Default', type: _InputType.defaultField),
      (label: 'Button', type: _InputType.button),
      (label: 'Community', type: _InputType.community),
      (label: 'CommunityAnswer', type: _InputType.communityAnswer),
    ];

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
      },
      children: [
        for (final row in rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 16),
                child: Text(row.label, style: labelStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(width: 335, child: _buildPreview(row.type)),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(_InputType type) {
    return switch (type) {
      _InputType.defaultField => const GdsInput(
        placeholder: 'Input filled',
        titleText: 'Title',
        helperText: 'Helper text',
      ),
      _InputType.button => const GdsInput.button(
        buttonLabel: 'label',
        placeholder: 'Input filled',
        titleText: 'Title',
        helperText: 'Helper text',
      ),
      _InputType.community => const GdsInput.community(
        placeholder: '댓글 입력',
      ),
      _InputType.communityAnswer => const GdsInput.communityAnswer(
        replyUser: 'user',
        placeholder: 'Input filled',
        mentionUser: 'user',
      ),
    };
  }
}
