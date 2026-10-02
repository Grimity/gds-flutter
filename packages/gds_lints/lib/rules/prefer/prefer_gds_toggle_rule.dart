import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Switch] 대신 [GdsToggle] 사용을 안내하는 규칙.
final class PreferGdsToggleRule extends PreferGdsWidgetRule {
  PreferGdsToggleRule()
    : super(
        name: 'prefer_gds_toggle',
        description: 'Flutter Switch 대신 GdsToggle을 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Switch', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsToggle', packageName: 'gds_flutter'),
  );
}
