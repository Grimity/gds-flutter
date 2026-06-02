import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsTab, path: '[component]/[tab]')
Widget buildGdsTabUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Tab',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  int tabIndex = 0;

  return StatefulBuilder(
    builder: (context, setState) {
      final size = context.knobs.list<GdsTabSize>(
        label: 'size',
        options: GdsTabSize.values,
        labelBuilder: (v) => v.name,
      );

      return WidgetbookPlayground(
        info: [
          'index: $tabIndex',
          'size: ${size.name}',
        ],
        child: GdsTab(
          index: tabIndex,
          size: size,
          items: [
            GdsTabItem(label: 'Text', badge: 'NN', onTap: () => setState(() => tabIndex = 0)),
            GdsTabItem(label: 'Text', badge: 'NN', onTap: () => setState(() => tabIndex = 1)),
            GdsTabItem(label: 'Text', badge: 'NN', onTap: () => setState(() => tabIndex = 2)),
          ],
        ),
      );
    },
  );
}
