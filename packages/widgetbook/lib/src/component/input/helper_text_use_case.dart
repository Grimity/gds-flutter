import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsHelperText, path: '[component]/[input]')
Widget buildGdsHelperTextUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'HelperText',
    description:
        '텍스트 필드 하단에 표시되는 보조 텍스트 컴포넌트입니다.\n'
        'Normal / Error / Success 세 가지 상태를 제공합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final state = context.knobs.list<GdsHelperTextState>(
    label: 'state',
    options: GdsHelperTextState.values,
    labelBuilder: (s) => s.name,
  );

  final text = context.knobs.stringOrNull(
    label: 'text',
    initialValue: 'Helper text',
  );

  final showCount = context.knobs.boolean(label: 'showCount', initialValue: false);

  return WidgetbookPlayground(
    info: [
      'state: ${state.name}',
      'text: $text',
      'showCount: $showCount',
    ],
    child: SizedBox(
      width: 300,
      child: GdsHelperText(
        state: state,
        text: text,
        currentCount: showCount ? 6 : null,
        maxCount: showCount ? 100 : null,
      ),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'HelperText',
    children: [
      WidgetbookSubsection(
        title: 'state × content',
        labels: ['3 states', '3 content types'],
        content: const _HelperTextMatrix(),
      ),
    ],
  );
}

enum _ContentType {
  textOnly,
  countOnly,
  textAndCount;

  String get label => switch (this) {
    _ContentType.textOnly => 'text only',
    _ContentType.countOnly => 'count only',
    _ContentType.textAndCount => 'text + count',
  };

  String? get text => switch (this) {
    _ContentType.textOnly => 'Helper text',
    _ContentType.countOnly => null,
    _ContentType.textAndCount => 'Helper text',
  };

  int? get currentCount => switch (this) {
    _ContentType.textOnly => null,
    _ContentType.countOnly => 6,
    _ContentType.textAndCount => 6,
  };

  int? get maxCount => switch (this) {
    _ContentType.textOnly => null,
    _ContentType.countOnly => 100,
    _ContentType.textAndCount => 100,
  };
}

class _HelperTextMatrix extends StatelessWidget {
  const _HelperTextMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final content in _ContentType.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(child: Text(content.label, style: labelStyle)),
              ),
          ],
        ),
        for (final state in GdsHelperTextState.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(state.name, style: labelStyle),
              ),
              for (final content in _ContentType.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 180,
                    child: GdsHelperText(
                      state: state,
                      text: content.text,
                      currentCount: content.currentCount,
                      maxCount: content.maxCount,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
