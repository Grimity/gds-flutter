import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(name: 'default', type: GdsModal, path: '[component]/[popup]')
Widget buildGdsModalUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Modal',
    children: [
      _buildPlaygroundSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final colors = context.gdsColors;

  final title = context.knobs.string(
    label: 'title',
    initialValue: '제목',
  );

  final primary = context.knobs.boolean(
    label: 'primaryButton',
    initialValue: true,
  );

  final secondary = context.knobs.boolean(
    label: 'secondaryButton',
    initialValue: true,
  );

  return WidgetbookPlayground(
    info: [
      'title: $title',
      'primaryButton: $primary',
      'secondaryButton: $secondary',
    ],
    child: GdsModal(
      title: title,
      onClose: () => debugPrint('Close Tapped'),
      action: GdsModalAction(
        icon: GdsIcon.blank,
        onTap: () => debugPrint('Action Tapped'),
      ),
      onPrimary: primary ? () => debugPrint('Primary Tapped') : null,
      onSecondary: secondary ? () => debugPrint('Secondary Tapped') : null,
      body: Container(
        height: 250,
        color: colors.surface.graySubtler,
      ),
    ),
  );
}
