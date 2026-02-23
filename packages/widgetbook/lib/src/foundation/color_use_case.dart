import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'Atomic',
  type: GdsColors,
  path: '[foundation]/',
)
Widget buildGdsAtomicColorsUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Atomic Colors',
    description: '디자인 시스템의 기본 색상 팔레트입니다. 직접 사용보다는 Semantic Color를 통해 참조합니다.',
    children: [
      _buildPaletteSection('Base', const [
        _ColorItem('white', GdsColors.white),
        _ColorItem('black', GdsColors.black),
      ]),
      _buildPaletteSection(
        'Gray',
        _shadesFrom('gray', [
          GdsColors.gray10,
          GdsColors.gray20,
          GdsColors.gray30,
          GdsColors.gray40,
          GdsColors.gray50,
          GdsColors.gray60,
          GdsColors.gray70,
          GdsColors.gray80,
          GdsColors.gray90,
          GdsColors.gray100,
        ]),
      ),
      _buildPaletteSection(
        'Blue',
        _shadesFrom('blue', [
          GdsColors.blue10,
          GdsColors.blue20,
          GdsColors.blue30,
          GdsColors.blue40,
          GdsColors.blue50,
          GdsColors.blue60,
          GdsColors.blue70,
          GdsColors.blue80,
          GdsColors.blue90,
          GdsColors.blue100,
        ]),
      ),
      _buildPaletteSection(
        'Green',
        _shadesFrom('green', [
          GdsColors.green10,
          GdsColors.green20,
          GdsColors.green30,
          GdsColors.green40,
          GdsColors.green50,
          GdsColors.green60,
          GdsColors.green70,
          GdsColors.green80,
          GdsColors.green90,
          GdsColors.green100,
        ]),
      ),
      _buildPaletteSection(
        'Orange',
        _shadesFrom('orange', [
          GdsColors.orange10,
          GdsColors.orange20,
          GdsColors.orange30,
          GdsColors.orange40,
          GdsColors.orange50,
          GdsColors.orange60,
          GdsColors.orange70,
          GdsColors.orange80,
          GdsColors.orange90,
          GdsColors.orange100,
        ]),
      ),
      _buildPaletteSection(
        'Red',
        _shadesFrom('red', [
          GdsColors.red10,
          GdsColors.red20,
          GdsColors.red30,
          GdsColors.red40,
          GdsColors.red50,
          GdsColors.red60,
          GdsColors.red70,
          GdsColors.red80,
          GdsColors.red90,
          GdsColors.red100,
        ]),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Semantic',
  type: GdsColors,
  path: '[foundation]/',
)
Widget buildGdsSemanticColorsUseCase(BuildContext context) {
  final colors = context.gdsColors;

  return WidgetbookPageLayout(
    title: 'Semantic Colors',
    description: '테마(Light/Dark)에 따라 자동 전환되는 시맨틱 색상 토큰입니다.',
    children: [
      _buildPaletteSection('Background (bg)', [
        _ColorItem('primary', colors.bg.primary),
        _ColorItem('secondary', colors.bg.secondary),
        _ColorItem('tertiary', colors.bg.tertiary),
        _ColorItem('black', colors.bg.black),
      ]),
      _buildPaletteSection('Surface', [
        _ColorItem('base', colors.surface.base),
        _ColorItem('inverse', colors.surface.inverse),
        _ColorItem('grayBold', colors.surface.grayBold),
        _ColorItem('grayNormal', colors.surface.grayNormal),
        _ColorItem('graySubtle', colors.surface.graySubtle),
        _ColorItem('graySubtler', colors.surface.graySubtler),
        _ColorItem('graySubtlest', colors.surface.graySubtlest),
        _ColorItem('primaryNormal', colors.surface.primaryNormal),
        _ColorItem('primarySubtler', colors.surface.primarySubtler),
        _ColorItem('primarySubtlest', colors.surface.primarySubtlest),
      ]),
      _buildPaletteSection('Text', [
        _ColorItem('inverse', colors.text.inverse),
        _ColorItem('grayBold', colors.text.grayBold),
        _ColorItem('grayNormal', colors.text.grayNormal),
        _ColorItem('graySubtle', colors.text.graySubtle),
        _ColorItem('graySubtler', colors.text.graySubtler),
        _ColorItem('primaryNormal', colors.text.primaryNormal),
        _ColorItem('primarySubtle', colors.text.primarySubtle),
      ]),
      _buildPaletteSection('Icon', [
        _ColorItem('base', colors.icon.base),
        _ColorItem('inverse', colors.icon.inverse),
        _ColorItem('grayBold', colors.icon.grayBold),
        _ColorItem('grayNormal', colors.icon.grayNormal),
        _ColorItem('graySubtle', colors.icon.graySubtle),
        _ColorItem('graySubtler', colors.icon.graySubtler),
        _ColorItem('graySubtlest', colors.icon.graySubtlest),
        _ColorItem('primaryNormal', colors.icon.primaryNormal),
        _ColorItem('primarySubtle', colors.icon.primarySubtle),
      ]),
      _buildPaletteSection('Border', [
        _ColorItem('inverse', colors.border.inverse),
        _ColorItem('primaryNormal', colors.border.primaryNormal),
        _ColorItem('primarySubtle', colors.border.primarySubtle),
        _ColorItem('primarySubtler', colors.border.primarySubtler),
        _ColorItem('grayBold', colors.border.grayBold),
        _ColorItem('grayNormal', colors.border.grayNormal),
        _ColorItem('graySubtle', colors.border.graySubtle),
        _ColorItem('graySubtler', colors.border.graySubtler),
      ]),
      _buildPaletteSection('Status', [
        _ColorItem('positive', colors.status.positive),
        _ColorItem('info', colors.status.info),
        _ColorItem('negative', colors.status.negative),
        _ColorItem('cautionary', colors.status.cautionary),
        _ColorItem('notification', colors.status.notification),
      ]),
    ],
  );
}

// -- helpers --

Widget _buildPaletteSection(String title, List<_ColorItem> items) {
  return WidgetbookSection(
    title: title,
    children: [_SwatchRow(items: items)],
  );
}

List<_ColorItem> _shadesFrom(String prefix, List<Color> colors) {
  const shades = ['10', '20', '30', '40', '50', '60', '70', '80', '90', '100'];
  return List.generate(colors.length, (i) => _ColorItem('$prefix${shades[i]}', colors[i]));
}

class _SwatchRow extends StatelessWidget {
  const _SwatchRow({required this.items});

  final List<_ColorItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 767) {
          return Row(
            children: [for (final item in items) Expanded(child: _ColorSwatch(item: item))],
          );
        }
        return Wrap(
          runSpacing: 12,
          children: [for (final item in items) _ColorSwatch(item: item)],
        );
      },
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.item});

  final _ColorItem item;

  @override
  Widget build(BuildContext context) {
    final hex = '#${item.color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 64),
      child: Column(
        children: [
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: item.color,
              border: Border.all(color: Colors.black12),
            ),
          ),
          const SizedBox(height: 4),
          Text(item.label, style: GdsTypography.label5),
          Text(hex, style: GdsTypography.caption1.copyWith(color: GdsColors.gray50)),
        ],
      ),
    );
  }
}

class _ColorItem {
  const _ColorItem(this.label, this.color);

  final String label;
  final Color color;
}
