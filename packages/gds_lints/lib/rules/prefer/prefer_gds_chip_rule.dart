import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Chip] 대신 [GdsChip] 사용을 안내하는 규칙.
final class PreferGdsChipRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_chip',
        description: 'Flutter Chip 대신 GdsChip을 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Chip', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsChip', packageName: 'gds_flutter'),
  );
}
