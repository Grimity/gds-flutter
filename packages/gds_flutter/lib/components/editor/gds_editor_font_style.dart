import 'package:gds_flutter/gds_flutter.dart';

/// 에디터에서 사용할 수 있는 글꼴 스타일을 나타내는 열거형.
enum GdsEditorFontStyle {
  title1(.editorTitle1, '제목1'),
  title2(.editorTitle2, '제목2'),
  body(.editorBody, '본문');

  const GdsEditorFontStyle(
    this.style,
    this.label,
  );

  final GdsTypography style;
  final String label;
}
