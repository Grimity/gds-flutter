import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsBottomSheet,
  path: '[component]/[bottom_sheet]',
)
Widget buildGdsBottomSheetUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Bottom Sheet',
    children: [
      _buildBottomSheetSection(context),
    ],
  );
}

Widget _buildBottomSheetSection(BuildContext context) {
  final colors = context.gdsColors;

  final title = context.knobs.string(
    label: "title",
    initialValue: "제목",
  );

  final primaryLabel = context.knobs.string(
    label: "primary label",
    initialValue: "label",
  );

  final secondaryLabel = context.knobs.string(
    label: "secondary label",
    initialValue: "label",
  );

  final primaryButton = context.knobs.boolean(
    label: 'primary button',
    initialValue: true,
  );

  final secondaryButton = context.knobs.boolean(
    label: 'primary button',
    initialValue: true,
  );

  return WidgetbookPlayground(
    info: [
      'title: $title',
      'label: $primaryLabel / $secondaryLabel',
    ],
    child: Container(
      constraints: BoxConstraints(maxWidth: 375),
      child: GdsBottomSheet(
        title: title,
        onClose: () => debugPrint("Close Tapped"),
        onPrimaryTap: primaryButton ? () => debugPrint("Primary Tapped") : null,
        onSecondaryTap: secondaryButton ? () => debugPrint("Primary Tapped") : null,
        primaryLabel: primaryLabel,
        secondaryLabel: secondaryLabel,
        child: Container(
          width: double.infinity,
          height: 300,
          color: colors.surface.graySubtler,
          alignment: Alignment.center,
          child: Text(
            "Content",
            style: GdsTypography.title2.copyWith(color: colors.surface.graySubtle),
          ),
        ),
      ),
    ),
  );
}
