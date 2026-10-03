import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Container], [AnimatedContainer] 대신 [GdsContainer] 사용을 안내하는 규칙.
final class PreferGdsContainerRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_container',
        description: 'Flutter Container 대신 GdsContainer를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [
      WidgetTypeReference(name: 'Container', packageName: 'flutter'),
      WidgetTypeReference(name: 'AnimatedContainer', packageName: 'flutter'),
    ],
    target: WidgetTypeReference(name: 'GdsContainer', packageName: 'gds_flutter'),
  );
}
