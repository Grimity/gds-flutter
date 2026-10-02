import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Icon] 대신 [GdsIcon] 사용을 안내하는 규칙.
final class PreferGdsIconRule extends PreferGdsWidgetRule {
  PreferGdsIconRule()
    : super(
        name: 'prefer_gds_icon',
        description: 'Flutter Icon 대신 GdsIcon을 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Icon', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsIcon', packageName: 'gds_flutter'),
  );
}
