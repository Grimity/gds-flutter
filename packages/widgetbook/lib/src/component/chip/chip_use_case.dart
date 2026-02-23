import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsChip, path: '[component]/[chip]')
Widget buildGdsChipUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Chip',
    description: '카테고리, 태그 등을 표시하는 칩 컴포넌트입니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsChipSize>(
    label: 'size',
    options: GdsChipSize.values,
    labelBuilder: (s) => s.name,
  );

  final variant = context.knobs.list<GdsChipVariant>(
    label: 'variant',
    options: GdsChipVariant.values,
    labelBuilder: (v) => v.name,
  );

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
      'variant: ${variant.name}',
      'hPadding: ${size.horizontalPadding.toInt()}px @fixed',
      'radius: full @fixed',
    ],
    child: GdsChip(
      text: 'Label',
      size: size,
      variant: variant,
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Chip',
    children: [
      WidgetbookSubsection(
        title: 'size × variant',
        labels: ['2 sizes', '2 variants'],
        content: const _ChipMatrix(),
      ),
    ],
  );
}

class _ChipMatrix extends StatelessWidget {
  const _ChipMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final size in GdsChipSize.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(size.name, style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final variant in GdsChipVariant.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(variant.name, style: headerStyle),
              ),
              for (final size in GdsChipSize.values)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: GdsChip(
                      text: 'Label',
                      size: size,
                      variant: variant,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
