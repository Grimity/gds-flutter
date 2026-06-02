import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsAlert, path: '[component]/[popup]')
Widget buildGdsAlertUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Alert',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final type = context.knobs.list<GdsAlertType>(
    label: 'type',
    options: GdsAlertType.values,
    labelBuilder: (v) => v.name,
  );

  final size = context.knobs.list<GdsAlertSize>(
    label: 'size',
    options: GdsAlertSize.values,
    labelBuilder: (v) => v.name,
  );

  final title = context.knobs.string(
    label: 'title',
    initialValue: 'Main text',
  );

  final description = context.knobs.string(
    label: 'description',
    initialValue: '상황에 대한 설명이 들어가요.\n설명은 최대 2줄까지만 작성해요.',
  );

  return WidgetbookPlayground(
    info: [
      'type: ${type.name}',
      'size: ${size.name}',
      'title: $title}',
      'description: $description',
    ],
    child: GdsAlert(
      type: type,
      size: size,
      title: title,
      description: description,
      onPrimaryTap: () => debugPrint('Primary Tapped'),
      onSecondaryTap: () => debugPrint('Secondary Tapped'),
    ),
  );
}
