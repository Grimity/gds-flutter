import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsNavigation,
  path: '[component]/[pagination]'
)
Widget buildGdsNavigationUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Navigation',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  int index = 0;

  return StatefulBuilder(
    builder: (context, setState) {
      final pageCount = context.knobs.int.slider(
        label: 'pageCount',
        min: 1,
        max: 10,
        initialValue: 10,
        divisions: 10,
        description: '총 페이지 수',
      );

      final maxCount = context.knobs.int.slider(
        label: 'maxCount',
        min: 1,
        max: 10,
        initialValue: 5,
        divisions: 10,
        description: '한 번에 표시할 최대 버튼 수',
      );

      return WidgetbookPlayground(
        info: [
          'index: $index',
          'pageCount: $pageCount',
          'maxCount: $maxCount',
        ],
        child: GdsNavigation(
          index: index,
          pageCount: pageCount,
          maxCount: maxCount,
          onPageChanged: (newIndex) => setState(() => index = newIndex),
        ),
      );
    }
  );
}
