import 'package:gds_lints/rules/prefer/prefer_gds_widget_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// 기존 Flutter의 [GestureDetector], [InkWell] 대신 [GdsGesture] 사용을 안내하는 규칙.
final class PreferGdsGestureRule extends PreferGdsWidgetRule {
  new()
    : super(
        name: 'prefer_gds_gesture',
        description: 'Flutter 제스처 위젯 대신 GdsGesture를 사용하세요.',
      );

  @override
  WidgetReplacement get replacement => const WidgetReplacement(
    sources: [
      WidgetTypeReference(name: 'GestureDetector', packageName: 'flutter'),
      WidgetTypeReference(name: 'InkWell', packageName: 'flutter'),
    ],
    target: WidgetTypeReference(name: 'GdsGesture', packageName: 'gds_flutter'),
  );
}
