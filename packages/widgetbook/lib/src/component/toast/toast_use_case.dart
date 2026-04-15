import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsToast,
  path: '[component]/[toast]',
)
Widget buildGdsToastUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Toast',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsToastType>(
    label: 'type',
    options: GdsToastType.values,
    labelBuilder: (type) => type.name,
  );

  final message = context.knobs.string(
    label: 'message',
    initialValue: '안내 메세지',
  );

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'message: $message',
    ],
    child: GdsToast(
      type: type,
      message: message,
    ),
  );
}
