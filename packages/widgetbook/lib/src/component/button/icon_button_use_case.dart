import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

enum _IconColorMode {
  buttonDefault,
  custom,
}

String _toHex(Color color) => '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';

@widgetbook.UseCase(
  name: 'default',
  type: GdsIconButton,
  path: '[component]/[button]/',
)
Widget buildGdsIconButtonUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'IconButton',
    description: '아이콘 전용 버튼입니다. small, normal, outlined, solid 4가지 타입을 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsIconButtonType>(
    label: 'type',
    options: GdsIconButtonType.values,
    labelBuilder: (t) => t.name,
  );

  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);

  final icon = context.knobs.list<GdsIcon>(
    label: 'icon',
    options: [
      GdsIcon.heartFill,
      GdsIcon.bellFill,
      GdsIcon.settings,
      GdsIcon.share,
      GdsIcon.trash,
      GdsIcon.penFill,
      GdsIcon.bookmarkFill,
      GdsIcon.xMark,
      GdsIcon.plus,
      GdsIcon.magnifierFill,
    ],
    initialOption: GdsIcon.heartFill,
    labelBuilder: (i) => i.name,
  );
  final iconColorMode = context.knobs.list<_IconColorMode>(
    label: 'iconColorMode',
    options: _IconColorMode.values,
    initialOption: _IconColorMode.buttonDefault,
    labelBuilder: (mode) => mode.name,
  );
  Color? customIconColor;
  final iconColor = switch (iconColorMode) {
    _IconColorMode.buttonDefault => null,
    _IconColorMode.custom => customIconColor = context.knobs.color(
      label: 'customIconColor',
      initialValue: const Color(0xFFE53935),
    ),
  };

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'enabled: $enabled',
      'icon: ${icon.name}',
      'iconColorMode: ${iconColorMode.name}',
      if (customIconColor != null) 'customIconColor: ${_toHex(customIconColor)}',
      'iconSize: ${type.iconSize.toInt()}px @fixed',
      'padding: ${type.padding.toInt()}px @fixed',
    ],
    child: GdsIconButton(
      icon: icon,
      iconColor: iconColor,
      type: type,
      enabled: enabled,
      onPressed: () => debugPrint('GdsIconButton tapped'),
    ),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'IconButton',
    children: [
      WidgetbookSubsection(
        title: 'type × state',
        labels: ['4 types', '5 states'],
        content: const _IconButtonMatrix(),
      ),
    ],
  );
}

class _IconButtonMatrix extends StatelessWidget {
  const _IconButtonMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final textStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);

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
            for (final state in GdsButtonState.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(child: Text(state.name, style: textStyle)),
              ),
          ],
        ),
        for (final type in GdsIconButtonType.values)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(type.name, style: textStyle),
              ),
              for (final state in GdsButtonState.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: _buildPreview(type, state, context),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPreview(
    GdsIconButtonType type,
    GdsButtonState state,
    BuildContext context,
  ) {
    final colors = context.gdsColors;

    return Container(
      decoration: BoxDecoration(
        color: type.backgroundColor(colors, state),
        border: type.border(colors, state),
        borderRadius: BorderRadius.circular(GdsRadius.full),
      ),
      padding: EdgeInsets.all(type.padding),
      child: GdsIcon.blank.build(
        color: type.iconColor(colors, state),
        width: type.iconSize,
        height: type.iconSize,
      ),
    );
  }
}
