import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsTextArea, path: '[component]/[input]')
Widget buildGdsTextAreaUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'TextArea',
    description:
        '여러 줄 텍스트를 입력할 수 있는 영역 컴포넌트입니다.\n'
        'Default / Underline / Text / SM 네 가지 타입을 제공합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsTextAreaType>(
    label: 'type',
    options: GdsTextAreaType.values,
    labelBuilder: (t) => t.name,
  );

  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final error = context.knobs.boolean(label: 'error', initialValue: false);

  final Widget field = switch (type) {
    GdsTextAreaType.defaultField => GdsTextArea(
      maxLength: 100,
      placeholder: 'placeholder',
      enabled: enabled,
      error: error,
    ),
    GdsTextAreaType.underline => GdsTextArea.underline(
      maxLength: 100,
      placeholder: 'placeholder',
      enabled: enabled,
      error: error,
    ),
    GdsTextAreaType.text => GdsTextArea.text(
      maxLength: 100,
      placeholder: 'placeholder',
      enabled: enabled,
      error: error,
    ),
    GdsTextAreaType.small => GdsTextArea.sm(
      maxLength: 100,
      placeholder: 'placeholder',
      enabled: enabled,
      error: error,
    ),
  };

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'enabled: $enabled',
      'error: $error',
      'containerHeight: ${type.containerHeight?.toInt() ?? 'auto'}px',
      'radius: ${type.borderRadius}',
    ],
    child: SizedBox(width: 300, child: field),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'TextArea',
    children: [
      WidgetbookSubsection(
        title: 'type × state',
        labels: ['4 types', '5 states'],
        content: const _TextAreaMatrix(),
      ),
    ],
  );
}

class _TextAreaMatrix extends StatelessWidget {
  const _TextAreaMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
        5: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final state in GdsTextAreaState.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(child: Text(state.name, style: labelStyle)),
              ),
          ],
        ),
        for (final type in GdsTextAreaType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Text(type.name, style: labelStyle),
              ),
              for (final state in GdsTextAreaState.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 160,
                    child: _buildPreview(type, state, context),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(
    GdsTextAreaType type,
    GdsTextAreaState state,
    BuildContext context,
  ) {
    final colors = context.gdsColors;
    const demoText = 'Input filled';
    final hasText = state != GdsTextAreaState.enabled && state != GdsTextAreaState.disabled;
    const demoMaxLength = 100;
    final demoCurrentLength = hasText ? demoText.length : 0;

    final textWidget = Text(
      hasText ? demoText : 'placeholder',
      style: type.textStyle.copyWith(
        color: hasText ? type.inputTextColor(colors, state) : type.placeholderColor(colors, state),
      ),
    );

    final contentHeight = type.contentHeight;
    Widget content;
    if (contentHeight != null) {
      content = SizedBox(height: contentHeight, child: textWidget);
    } else {
      content = Expanded(child: textWidget);
    }

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        content,
        SizedBox(height: type.gap),
        Align(
          alignment: Alignment.centerRight,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$demoCurrentLength',
                  style: GdsTypography.label5.copyWith(
                    color: type.countCurrentColor(colors, state),
                  ),
                ),
                TextSpan(
                  text: '/$demoMaxLength',
                  style: GdsTypography.label5.copyWith(
                    color: type.countRestColor(colors, state),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    final inner = Container(
      padding: type.padding,
      decoration: BoxDecoration(
        color: type.backgroundColor(colors, state),
        border: type.border(colors, state),
        borderRadius: type.borderRadius,
      ),
      child: column,
    );

    final containerHeight = type.containerHeight;
    if (containerHeight != null) {
      return SizedBox(height: containerHeight, child: inner);
    }
    return inner;
  }
}
