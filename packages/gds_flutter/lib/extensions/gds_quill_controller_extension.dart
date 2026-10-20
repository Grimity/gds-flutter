import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

/// 디자인 시스템에서 제공하는 [QuillController]에 대한 유틸리티 확장.
extension GdsQuillControllerExtension on QuillController {
  /// 문서 끝의 필수 줄바꿈을 제외한 글자 수를 반환합니다.
  int get characterCount => document.toPlainText().length - 1;

  /// 공백과 줄바꿈뿐이면 true를 반환하며, 이미지 등의 임베드는 내용으로 취급합니다.
  bool get isEmpty {
    return document.toDelta().toList().every((operation) {
      final data = operation.data;
      return data is String && data.trim().isEmpty;
    });
  }

  /// 이미지 등의 임베드를 제외하고 공백이 아닌 텍스트가 있는지 여부.
  bool get hasText {
    return document.toDelta().toList().any((operation) {
      final data = operation.data;
      return data is String && data.trim().isNotEmpty;
    });
  }

  /// 선택 영역에 서식을 적용하며, 동일한 서식이 적용되어 있으면 해제합니다.
  void toggleFormat(Attribute attribute) {
    final current = getSelectionStyle().attributes[attribute.key]?.value;
    final value = attribute.value;
    final isColor = attribute.key == Attribute.color.key || attribute.key == Attribute.background.key;
    final selected = isColor && current is String && value is String
        ? current.toUpperCase() == value.toUpperCase()
        : current == value;

    formatSelection(selected ? Attribute.clone(attribute, null) : attribute);
  }

  /// 본문의 텍스트와 서식, 이미지 등을 HTML 문자열로 변환합니다.
  String toHtml() {
    return QuillDeltaToHtmlConverter(document.toDelta().toJson()).convert();
  }

  /// HTML 문자열을 Quill 문서로 변환하여 기존 본문을 교체합니다.
  void loadHtml(String html) {
    document = Document.fromDelta(HtmlToDelta().convert(html));
  }
}
