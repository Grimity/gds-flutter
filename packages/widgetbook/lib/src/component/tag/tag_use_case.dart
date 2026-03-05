import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

enum _TagType { text, icon }

@widgetbook.UseCase(name: 'default', type: GdsTag, path: '[component]/[tag]')
Widget buildGdsTagUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Tag',
    description: '간단한 상태/속성을 표시하는 태그 컴포넌트입니다. Type(Default/Icon), State(Enabled/Disabled), Size(md/xs)를 지원합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final text = context.knobs.string(label: 'text', initialValue: 'Text');
  final type = context.knobs.list<_TagType>(
    label: 'type',
    options: _TagType.values,
    labelBuilder: (v) => v.name,
  );
  final size = context.knobs.list<GdsTagSize>(
    label: 'size',
    options: GdsTagSize.values,
    labelBuilder: (v) => v.name,
  );
  final state = context.knobs.list<GdsTagState>(
    label: 'state',
    options: GdsTagState.values,
    labelBuilder: (v) => v.name,
  );
  final icon = context.knobs.list<GdsIcon>(
    label: 'icon',
    options: const [GdsIcon.plus, GdsIcon.heartFill, GdsIcon.bellFill, GdsIcon.xMark],
    initialOption: GdsIcon.plus,
    labelBuilder: (v) => v.name,
  );

  final tag = switch (type) {
    _TagType.text => GdsTag(
      text: text,
      size: size,
      state: state,
      onTap: () => debugPrint('GdsTag tapped'),
    ),
    _TagType.icon => GdsTag.icon(
      text: text,
      icon: icon,
      size: size,
      state: state,
      onTap: () => debugPrint('GdsTag tapped'),
    ),
  };

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'size: ${size.name}',
      'state: ${state.name}',
      'padding: ${_paddingInfo(type, size)}',
      'radius: full @fixed',
      'textStyle: label4 @fixed',
      if (type == _TagType.icon) 'icon: ${icon.name}, 16x16px @fixed, gap: 4px @fixed',
    ],
    child: tag,
  );
}

String _paddingInfo(_TagType type, GdsTagSize size) => switch ((type, size)) {
  (_TagType.text, GdsTagSize.medium) => 'L16 T8 R16 B8',
  (_TagType.text, GdsTagSize.small) => 'L12 T6 R12 B6',
  (_TagType.icon, GdsTagSize.medium) => 'L16 T8 R12 B8',
  (_TagType.icon, GdsTagSize.small) => 'L12 T6 R10 B6',
};

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Tag',
    children: [
      WidgetbookSubsection(
        title: 'state × type/size',
        labels: ['2 states', '4 variants'],
        content: const _TagMatrix(),
      ),
    ],
  );
}

class _TagMatrix extends StatelessWidget {
  const _TagMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final headerStyle = GdsTypography.caption1.copyWith(color: colors.text.graySubtle);
    const columns = [
      (GdsTagState.enabled, GdsTagSize.medium, 'enabled/md'),
      (GdsTagState.disabled, GdsTagSize.medium, 'disabled/md'),
      (GdsTagState.enabled, GdsTagSize.small, 'enabled/xs'),
      (GdsTagState.disabled, GdsTagSize.small, 'disabled/xs'),
    ];
    const rows = [
      (_TagType.text, 'default'),
      (_TagType.icon, 'icon'),
    ];

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final (_, _, label) in columns)
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
        for (final (type, typeLabel) in rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(typeLabel, style: headerStyle),
              ),
              for (final (state, size, _) in columns)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: switch (type) {
                      _TagType.text => GdsTag(
                        text: 'Text',
                        size: size,
                        state: state,
                        onTap: () {},
                      ),
                      _TagType.icon => GdsTag.icon(
                        text: 'Text',
                        icon: GdsIcon.plus,
                        size: size,
                        state: state,
                        onTap: () {},
                      ),
                    },
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
