import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [TextField], [TextFormField] 대신 [GdsTextField] 사용을 안내하는 규칙.
final class PreferGdsTextFieldRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_text_field',
        description: 'Flutter 텍스트 입력 위젯 대신 GdsTextField를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [
      WidgetTypeReference(name: 'TextField', packageName: 'flutter'),
      WidgetTypeReference(name: 'TextFormField', packageName: 'flutter'),
    ],
    target: WidgetTypeReference(name: 'GdsTextField', packageName: 'gds_flutter'),
  );
}
