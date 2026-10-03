import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Scaffold] 대신 [GdsScaffold] 사용을 안내하는 규칙.
final class PreferGdsScaffoldRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_scaffold',
        description: 'Flutter Scaffold 대신 GdsScaffold를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Scaffold', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsScaffold', packageName: 'gds_flutter'),
  );
}
