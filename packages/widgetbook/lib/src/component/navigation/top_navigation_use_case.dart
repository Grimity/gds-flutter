import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsTopNavigation,
  path: '[component]/[navigation]',
)
Widget buildGdsTopNavigationUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Top Navigation',
    description: '화면 상단에 위치한 내비게이션으로, 작은 화면을 디자인할 때 사용합니다.',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsTopNavigationType>(
    label: 'type',
    options: GdsTopNavigationType.values,
    labelBuilder: (type) => type.displayName,
  );

  return WidgetbookPlayground(
    info: ['type: ${type.displayName}'],
    child: GdsTopNavigation.of(type),
  );
}
