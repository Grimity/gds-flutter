import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsModal,
  path: '[component]/[popup]'
)
Widget buildGdsModalUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Modal',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  return WidgetbookPlayground(
    info: [],
    child: GdsModal(),
  );
}
