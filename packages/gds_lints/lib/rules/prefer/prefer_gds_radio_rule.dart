import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Radio] 대신 [GdsRadio] 사용을 안내하는 규칙.
final class PreferGdsRadioRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_radio',
        description: 'Flutter Radio 대신 GdsRadio를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Radio', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsRadio', packageName: 'gds_flutter'),
  );
}
