import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Text] 대신 [GdsText] 사용을 안내하는 규칙.
final class PreferGdsTextRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_text',
        description: 'Flutter Text 대신 GdsText를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Text', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsText', packageName: 'gds_flutter'),
  );
}
