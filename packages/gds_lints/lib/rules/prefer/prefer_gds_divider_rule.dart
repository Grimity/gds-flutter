import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Divider], [VerticalDivider] 대신 [GdsDivider] 사용을 안내하는 규칙.
final class PreferGdsDividerRule extends PreferGdsWidgetRule {
  PreferGdsDividerRule()
    : super(
        name: 'prefer_gds_divider',
        description: 'Flutter 구분선 위젯 대신 GdsDivider를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [
      WidgetTypeReference(name: 'Divider', packageName: 'flutter'),
      WidgetTypeReference(name: 'VerticalDivider', packageName: 'flutter'),
    ],
    target: WidgetTypeReference(name: 'GdsDivider', packageName: 'gds_flutter'),
  );
}
