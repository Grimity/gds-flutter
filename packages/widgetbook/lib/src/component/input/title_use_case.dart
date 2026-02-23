import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsTitle, path: '[component]/[input]')
Widget buildGdsTitleUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Title',
    description: '폼 필드 등에 사용하는 레이블 컴포넌트입니다.\nisRequired가 true이면 빨간 * 이 표시됩니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final text = context.knobs.string(label: 'text', initialValue: 'Title');
  final isRequired = context.knobs.boolean(label: 'isRequired', initialValue: true);

  return WidgetbookPlayground(
    info: [
      'text: $text',
      'isRequired: $isRequired',
    ],
    child: GdsTitle(text: text, isRequired: isRequired),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Title',
    children: [
      WidgetbookSubsection(
        title: 'isRequired',
        labels: ['2 states'],
        content: const _TitleMatrix(),
      ),
    ],
  );
}

class _TitleMatrix extends StatelessWidget {
  const _TitleMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final labelStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Center(child: Text('default', style: labelStyle)),
            ),
          ],
        ),
        for (final isRequired in [true, false])
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text('isRequired: $isRequired', style: labelStyle),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GdsTitle(text: 'Title', isRequired: isRequired),
              ),
            ],
          ),
      ],
    );
  }
}
