import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsEditor]에 대한 프리뷰 위젯.
class GdsEditorPreview extends PreviewWidget {
  final statusControl = PreviewControl.select<GdsEditorStatus>(
    defaultValue: .none,
    displayName: 'Type',
    values: GdsEditorStatus.values,
  );

  // 툴바 관련
  final boldControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Bold',
  );

  final italicControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Italic',
  );

  final underlineControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Underline',
  );

  final strikethroughControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Strikethrough',
  );

  // 패널 관련
  final fontStyleControl = PreviewControl.select<GdsEditorFontStyle>(
    displayName: 'Font Style',
    values: GdsEditorFontStyle.values,
  );

  final fontColorControl = PreviewControl.select<GdsEditorFontColor>(
    displayName: 'Font Color',
    values: GdsEditorFontColor.values,
  );

  final fontBgColorControl = PreviewControl.select<GdsEditorFontColor>(
    displayName: 'Font Background Color',
    values: GdsEditorFontColor.values,
  );

  @override
  String get displayName => 'Editor';

  @override
  List<String> get groups => ['Editor'];

  @override
  Widget build(BuildContext context) {
    final status = statusControl.of(context);

    // 툴바 관련
    final bold = boldControl.of(context);
    final italic = italicControl.of(context);
    final underline = underlineControl.of(context);
    final strikethrough = strikethroughControl.of(context);

    // 패널 관련
    final fontStyle = fontStyleControl.of(context);
    final fontColor = fontColorControl.of(context);
    final fontBgColor = fontBgColorControl.of(context);

    return GdsEditor(
      status: status.value,
      toolbar: .new(
        bold: (
          selected: bold.value,
          onChanged: (value) {
            debugPrint('GdsEditorToolbar.bold.onChanged($value) called');
            bold.value = value;
          },
        ),
        italic: (
          selected: italic.value,
          onChanged: (value) {
            debugPrint('GdsEditorToolbar.italic.onChanged($value) called');
            italic.value = value;
          },
        ),
        underline: (
          selected: underline.value,
          onChanged: (value) {
            debugPrint('GdsEditorToolbar.underline.onChanged($value) called');
            underline.value = value;
          },
        ),
        strikethrough: (
          selected: strikethrough.value,
          onChanged: (value) {
            debugPrint('GdsEditorToolbar.strikethrough.onChanged($value) called');
            strikethrough.value = value;
          },
        ),
        onChanged: (value) {
          debugPrint('GdsEditorToolbar.onChanged($value) called');
          status.value = value;
        },
        onUndo: () => debugPrint('onUndo() called'),
        onRedo: () => debugPrint('onRedo() called'),
        onClose: () {
          debugPrint('onClose() called');
          status.value = .none;
        },
      ),
      panel: .new(
        fontStyle: fontStyle.mayBeValue,
        fontColor: fontColor.mayBeValue,
        fontBgColor: fontBgColor.mayBeValue,
        onAddImage: () => debugPrint('GdsEditorSheet.onAddImage() called'),
        onAddLink: () => debugPrint('GdsEditorSheet.onAddLink() called'),
        onFontStyleChanged: (newValue) {
          debugPrint('GdsEditorSheet.onFontStyleChanged($newValue) called');
          fontStyle.value = newValue;
        },
        onFontColorChanged: (newValue) {
          debugPrint('GdsEditorSheet.onFontColorChanged($newValue) called');
          fontColor.value = newValue;
        },
        onFontBgColorChanged: (newValue) {
          debugPrint('GdsEditorSheet.onFontBgColorChanged($newValue) called');
          fontBgColor.value = newValue;
        },
      ),
    );
  }
}
