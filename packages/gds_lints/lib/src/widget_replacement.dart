import 'package:analyzer/dart/element/element.dart';
import 'package:gds_lints/src/widget_type_reference.dart';

/// Flutter 위젯들을 GDS 위젯으로 대체하기 위한 정보를 정의하는 객체.
final class WidgetReplacement {
  const new({
    required this.sources,
    required this.target,
  });

  final List<WidgetTypeReference> sources;
  final WidgetTypeReference target;

  /// [element]가 대체 대상 위젯인지 확인합니다.
  bool matchesSource(InterfaceElement element) {
    return sources.any((source) => source.matches(element));
  }
}
