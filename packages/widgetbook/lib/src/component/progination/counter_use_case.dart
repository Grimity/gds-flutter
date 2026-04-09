import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsCounter,
  path: '[component]/[progination]'
)
Widget buildGdsCounterUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Counter',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final size = context.knobs.list<GdsCounterSize>(
    label: 'size',
    options: GdsCounterSize.values,
    labelBuilder: (v) => v.name,
  );

  final count = context.knobs.int.slider(
    label: 'count',
    min: 0,
    max: 10,
    initialValue: 1,
    divisions: 10,
  );

  final maxCount = context.knobs.int.slider(
    label: 'maxCount',
    min: count,
    max: 25,
    initialValue: 10, 
  );

  return WidgetbookPlayground(
    info: [
      'size: ${size.name}',
      'count: $count',
      'maxCount: $maxCount',
    ],
    child: GdsCounter(
      size: size,
      count: count,
      maxCount: maxCount,
    ),
  );
}
