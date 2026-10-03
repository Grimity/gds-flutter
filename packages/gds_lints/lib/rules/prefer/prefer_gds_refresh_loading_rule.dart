import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [CupertinoActivityIndicator] 대신 [GdsRefreshLoading] 사용을 안내하는 규칙.
final class PreferGdsRefreshLoadingRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_refresh_loading',
        description: 'Flutter CupertinoActivityIndicator 대신 GdsRefreshLoading을 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'CupertinoActivityIndicator', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsRefreshLoading', packageName: 'gds_flutter'),
  );
}
