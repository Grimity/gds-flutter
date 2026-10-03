import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [CircularProgressIndicator] 대신 [GdsCircularLoading] 사용을 안내하는 규칙.
final class PreferGdsCircularLoadingRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_circular_loading',
        description: 'Flutter CircularProgressIndicator 대신 GdsCircularLoading을 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'CircularProgressIndicator', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsCircularLoading', packageName: 'gds_flutter'),
  );
}
