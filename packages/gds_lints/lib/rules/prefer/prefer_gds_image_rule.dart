import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [Image] 대신 [GdsImage] 사용을 안내하는 규칙.
final class PreferGdsImageRule extends PreferGdsWidgetRule {
  PreferGdsImageRule()
    : super(
        name: 'prefer_gds_image',
        description: 'Flutter Image 대신 GdsImage를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [WidgetTypeReference(name: 'Image', packageName: 'flutter')],
    target: WidgetTypeReference(name: 'GdsImage', packageName: 'gds_flutter'),
  );
}
