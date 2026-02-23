import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsDivider)
Widget buildGdsDividerUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Divider',
    description: '요소와 요소 사이를 구분해 시각적 가독성을 높여요.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final isVertical = context.knobs.boolean(label: 'vertical', initialValue: false);

  final type = context.knobs.list<GdsDividerType>(
    label: 'type',
    options: GdsDividerType.values,
    labelBuilder: (t) => t.name,
  );

  final size = isVertical
      ? GdsDividerSize.vertical
      : context.knobs.list<GdsDividerSize>(
          label: 'size',
          options: [GdsDividerSize.normal, GdsDividerSize.bold],
          labelBuilder: (s) => s.name,
        );

  final isValid = type != GdsDividerType.brand || size == GdsDividerSize.normal;

  if (!isValid) {
    return WidgetbookPlayground(
      info: ['type: ${type.name}', 'size: ${size.name}', 'brand 타입은 normal 사이즈만 지원합니다. @fixed'],
      child: const SizedBox.shrink(),
    );
  }

  final Widget dividerWidget = isVertical
      ? SizedBox(
          height: 100,
          child: GdsDivider(type: type, size: size),
        )
      : GdsDivider(type: type, size: size);

  return WidgetbookPlayground(
    layout: isVertical ? PlaygroundLayout.center : PlaygroundLayout.stretch,
    info: ['type: ${type.name}', 'size: ${size.name}', 'thickness: ${size.thickness}px @fixed'],
    child: dividerWidget,
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Divider',
    spacing: 32,
    children: [
      WidgetbookSubsection(
        title: 'type',
        labels: ['brand', 'primary', 'secondary'],
        content: const Column(
          spacing: 24,
          children: [
            GdsDivider(type: GdsDividerType.brand),
            GdsDivider(type: GdsDividerType.primary),
            GdsDivider(type: GdsDividerType.secondary),
          ],
        ),
      ),
      WidgetbookSubsection(
        title: 'size',
        labels: ['normal', 'bold'],
        content: const Column(
          spacing: 24,
          children: [
            GdsDivider(type: GdsDividerType.primary, size: GdsDividerSize.normal),
            GdsDivider(type: GdsDividerType.primary, size: GdsDividerSize.bold),
          ],
        ),
      ),
      WidgetbookSubsection(
        title: 'direction',
        labels: ['vertical'],
        content: const SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              Text('Left'),
              GdsDivider(type: GdsDividerType.primary, size: GdsDividerSize.vertical),
              Text('Right'),
            ],
          ),
        ),
      ),
    ],
  );
}
