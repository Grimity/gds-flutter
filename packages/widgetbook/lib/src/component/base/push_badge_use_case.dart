import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'DotPushBadge',
  type: GdsDotPushBadge,
  path: '[component]/[base]/',
)
Widget buildGdsDotPushBadgeUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'DotPushBadge',
    description: '알림 존재 여부를 알려주는 점형 배지입니다.',
    children: [
      _buildDotPlaygroundSection(context),
      _buildDotDemonstrationSection(),
    ],
  );
}

Widget _buildDotPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsDotPushBadgeType>(
    label: 'type',
    options: GdsDotPushBadgeType.values,
    labelBuilder: (t) => t.name,
  );

  final position = context.knobs.list<GdsDotPushBadgePosition>(
    label: 'position',
    options: GdsDotPushBadgePosition.values,
    labelBuilder: (p) => p.name,
  );

  return WidgetbookPlayground(
    info: ['type: ${type.name}', 'size: ${type.size}px @fixed', 'position: ${position.name}'],
    child: GdsDotPushBadge(
      type: type,
      position: position,
      child: const Icon(Icons.notifications_outlined, size: 28),
    ),
  );
}

Widget _buildDotDemonstrationSection() {
  return WidgetbookSection(
    title: 'DotPushBadge',
    spacing: 32,
    children: [
      WidgetbookSubsection(
        title: 'type × position',
        labels: ['3 types', '4 positions', '12 combinations'],
        content: const _DotBadgeMatrix(),
      ),
    ],
  );
}

class _DotBadgeMatrix extends StatelessWidget {
  const _DotBadgeMatrix();

  @override
  Widget build(BuildContext context) {
    final subtleColor = context.gdsColors.text.graySubtle;

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final position in GdsDotPushBadgePosition.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Text(position.name, style: GdsTypography.label5.copyWith(color: subtleColor)),
                ),
              ),
          ],
        ),
        for (final type in GdsDotPushBadgeType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(type.name, style: GdsTypography.label5.copyWith(color: subtleColor)),
              ),
              for (final position in GdsDotPushBadgePosition.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: GdsDotPushBadge(
                      type: type,
                      position: position,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'NumberPushBadge',
  type: GdsNumberPushBadge,
  path: '[component]/[base]',
)
Widget buildGdsNumberPushBadgeUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'NumberPushBadge',
    description: '수치 정보를 표시하는 숫자형 배지입니다.',
    children: [
      _buildNumberPlaygroundSection(context),
      _buildNumberDemonstrationSection(),
    ],
  );
}

Widget _buildNumberPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsNumberPushBadgeType>(
    label: 'type',
    options: GdsNumberPushBadgeType.values,
    labelBuilder: (t) => t.name,
  );

  final count = context.knobs.int.input(label: 'count', initialValue: 5);

  return WidgetbookPlayground(
    info: ['type: ${type.name}', 'count: $count'],
    child: GdsNumberPushBadge(type: type, count: count),
  );
}

Widget _buildNumberDemonstrationSection() {
  return WidgetbookSection(
    title: 'NumberPushBadge',
    spacing: 32,
    children: [
      const WidgetbookSubsection(
        title: 'type',
        labels: ['solid', 'outline', 'text'],
        content: Row(
          spacing: 24,
          children: [
            GdsNumberPushBadge(type: GdsNumberPushBadgeType.solid, count: 3),
            GdsNumberPushBadge(type: GdsNumberPushBadgeType.outline, count: 3),
            GdsNumberPushBadge(type: GdsNumberPushBadgeType.text, count: 3),
          ],
        ),
      ),
    ],
  );
}
