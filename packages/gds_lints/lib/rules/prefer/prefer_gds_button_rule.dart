import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter 버튼 위젯 대신 [GdsButton] 사용을 안내하는 규칙.
final class PreferGdsButtonRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_button',
        description: 'Flutter 버튼 위젯 대신 GdsButton을 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [
      WidgetTypeReference(name: 'TextButton', packageName: 'flutter'),
      WidgetTypeReference(name: 'ElevatedButton', packageName: 'flutter'),
      WidgetTypeReference(name: 'FilledButton', packageName: 'flutter'),
      WidgetTypeReference(name: 'OutlinedButton', packageName: 'flutter'),
      WidgetTypeReference(name: 'IconButton', packageName: 'flutter'),
    ],
    target: WidgetTypeReference(name: 'GdsButton', packageName: 'gds_flutter'),
  );
}
