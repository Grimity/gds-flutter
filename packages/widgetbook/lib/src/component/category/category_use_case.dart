import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsCategory,
  path: '[component]/[category]'
)
Widget buildGdsCategoryUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Category',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  int categoryIndex = 0;

  return StatefulBuilder(
    builder: (context, setState) {
      final size = context.knobs.list<GdsCategorySize>(
        label: 'type',
        options: GdsCategorySize.values,
        labelBuilder: (v) => v.name,
      );

      return WidgetbookPlayground(
        info: [
          'index: $categoryIndex',
          'size: ${size.name}',
        ],
        child: GdsCategory(
          size: size,
          items: [
            GdsCategoryItem(label: 'Text NN', isActive: categoryIndex == 0, onTap: () => setState(() => categoryIndex = 0)),
            GdsCategoryItem(label: 'Text NN', isActive: categoryIndex == 1, onTap: () => setState(() => categoryIndex = 1)),
            GdsCategoryItem(label: 'Text NN', isActive: categoryIndex == 2, onTap: () => setState(() => categoryIndex = 2)),
            GdsCategoryItem(label: 'Text NN', isActive: categoryIndex == 3, onTap: () => setState(() => categoryIndex = 3)),
            GdsCategoryItem(label: 'Text NN', isActive: categoryIndex == 4, onTap: () => setState(() => categoryIndex = 4)),
          ],
          action: GdsCategoryAction(
            icon: GdsIcon.blank,
            onTap: () {},
          ),
        ),
      );
    },
  );
}
