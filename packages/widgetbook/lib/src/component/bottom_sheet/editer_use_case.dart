import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsEditor,
  path: '[component]/[bottom_sheet]',
)
Widget buildGdsEditorUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Editor',
    children: [
      _buildEditorSection(context),
      _buildEditorDecorationSection(context),
      _buildEditorButtonSection(context),
    ],
  );
}

Widget _buildEditorSection(BuildContext context) {
  final type = context.knobs.list<GdsEditorType>(
    label: 'type',
    options: GdsEditorType.values,
    labelBuilder: (t) => t.displayName,
  );

  final isBoldPressed = context.knobs.boolean(label: 'isBoldPressed', initialValue: false);
  final isItalicPressed = context.knobs.boolean(label: 'isItalicPressed', initialValue: false);
  final isUnderlinePressed = context.knobs.boolean(label: 'isUnderlinePressed', initialValue: false);
  final isStrikrthroughPressed = context.knobs.boolean(label: 'isStrikrthroughPressed', initialValue: false);

  return WidgetbookPlayground(
    info: [
      'type: ${type.displayName}',
      'pressed: $isBoldPressed $isItalicPressed $isUnderlinePressed $isStrikrthroughPressed',
    ],
    child: GdsEditor(
      type: type,
      isBoldPressed: isBoldPressed,
      isItalicPressed: isItalicPressed,
      isUnderlinePressed: isUnderlinePressed,
      isStrikethroughPressed: isStrikrthroughPressed,
      fontStyle: GdsEditorFontStyle.title2,
    ),
  );
}

Widget _buildEditorDecorationSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Editor Decoration',
    children: [
      // State = Enabled
      Row(
        spacing: GdsSpacing.spacing12,
        children: [
          for (final type in GdsEditorDecorationType.values)
            GdsEditorDecoration(type: type, state: GdsEditorDecorationState.enabled),
        ],
      ),

      // State = Preseed
      Row(
        spacing: GdsSpacing.spacing12,
        children: [
          for (final type in GdsEditorDecorationType.values)
            GdsEditorDecoration(type: type, state: GdsEditorDecorationState.pressed),
        ],
      ),
    ],
  );
}

Widget _buildEditorButtonSection(BuildContext context) {
  return WidgetbookSection(
    title: 'Editor Button',
    children: [
      Row(
        children: [
          for (final state in GdsEditorButtonState.values)
            SizedBox(
              width: 106,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: GdsSpacing.spacing12,
                children: [
                  GdsEditorButton.title1(context: context, state: state, title: "가나다", label: "제목1"),
                  GdsEditorButton.title2(context: context, state: state, title: "가나다", label: "제목2"),
                  GdsEditorButton.body(context: context, state: state, title: "가나다", label: "본문"),
                  GdsEditorButton.icon(context: context, state: state, icon: GdsIcon.blank, label: "버튼 명"),
                  GdsEditorButton.fontColor(context: context, state: state, color: Colors.white),
                  GdsEditorButton.fontBgColor(
                    context: context,
                    state: state,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}
