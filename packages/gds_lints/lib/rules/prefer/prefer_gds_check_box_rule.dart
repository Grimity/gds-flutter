import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Checkbox] 대신 [GdsCheckBox] 사용을 안내하는 규칙.
final class PreferGdsCheckBoxRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_check_box',
        description: 'Flutter Checkbox 대신 GdsCheckBox를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Checkbox', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsCheckBox', packageName: 'gds_flutter'),
  );
}
