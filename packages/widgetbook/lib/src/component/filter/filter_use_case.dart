import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsFilter, path: '[component]/[filter]')
Widget buildGdsFilterUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Filter',
    description: '하나의 값을 선택 용으로 선택, 값 저장, 폼 등에 사용됩니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final text = context.knobs.string(label: 'text', initialValue: '제목');
  final type = context.knobs.list<GdsFilterType>(
    label: 'type',
    options: GdsFilterType.values,
    labelBuilder: (value) => value.name,
  );
  final expanded = context.knobs.boolean(label: 'expanded', initialValue: false);
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'expanded: $expanded',
      'enabled: $enabled',
    ],
    child: GdsFilter(
      text: text,
      type: type,
      expanded: expanded,
      enabled: enabled,
      onTap: () => debugPrint('GdsFilter tapped'),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Filter',
    children: [
      WidgetbookSubsection(
        title: 'state × type/expanded',
        labels: ['5 states', '4 variants'],
        content: const _FilterMatrix(),
      ),
    ],
  );
}

class _FilterMatrix extends StatelessWidget {
  const _FilterMatrix();

  static const _columns = [
    (GdsButtonState.enabled, 'Enabled'),
    (GdsButtonState.focused, 'Focused'),
    (GdsButtonState.hovered, 'Hovered'),
    (GdsButtonState.pressed, 'Pressed'),
    (GdsButtonState.disabled, 'Disabled'),
  ];

  static const _rows = [
    (GdsFilterType.outline, false, 'outline/collapsed'),
    (GdsFilterType.outline, true, 'outline/expanded'),
    (GdsFilterType.text, false, 'text/collapsed'),
    (GdsFilterType.text, true, 'text/expanded'),
  ];

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
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
        5: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final (_, label) in _columns)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(label, style: headerStyle),
                  ),
                ),
              ),
          ],
        ),
        for (final (type, expanded, label) in _rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(label, style: headerStyle),
              ),
              for (final (state, _) in _columns)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: _StaticFilterPreview(
                      text: type == GdsFilterType.outline ? '제목' : '최신순',
                      type: type,
                      expanded: expanded,
                      state: state,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _StaticFilterPreview extends StatelessWidget {
  const _StaticFilterPreview({
    required this.text,
    required this.type,
    required this.expanded,
    required this.state,
  });

  final String text;
  final GdsFilterType type;
  final bool expanded;
  final GdsButtonState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: GdsFilterStyle.backgroundColor(colors, type, state),
        border: GdsFilterStyle.border(colors, type, state),
        borderRadius: GdsFilterStyle.borderRadius(type),
      ),
      child: SizedBox(
        height: GdsFilterStyle.height(type),
        child: Padding(
          padding: GdsFilterStyle.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GdsFilterStyle.textStyle.copyWith(
                    color: GdsFilterStyle.textColor(colors, state),
                  ),
                ),
              ),
              SizedBox(width: GdsFilterStyle.gap),
              GdsFilterStyle.icon(expanded).build(
                color: GdsFilterStyle.iconColor(colors, state),
                width: GdsIconSize.v16,
                height: GdsIconSize.v16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
