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
  final size = context.knobs.list<GdsTabSize>(
    label: 'size',
    options: GdsTabSize.values,
    labelBuilder: (v) => v.name,
  );

  return WidgetbookPlayground(
    info: ['size: ${size.name}'],
    child: _Playground(size: size),
  );
}

class _Playground extends StatefulWidget {
  const _Playground({required this.size});

  final GdsTabSize size;

  @override
  State<_Playground> createState() => __PlaygroundState();
}

class __PlaygroundState extends State<_Playground> with TickerProviderStateMixin {
  late final controller = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return GdsTab(
      controller: controller,
      size: widget.size,
      items: [
        GdsTabItem(label: 'Text', badge: 'NN', onTap: () => controller.animateTo(0)),
        GdsTabItem(label: 'Text', badge: 'NN', onTap: () => controller.animateTo(1)),
        GdsTabItem(label: 'Text', badge: 'NN', onTap: () => controller.animateTo(2)),
      ],
    );
  }
}
