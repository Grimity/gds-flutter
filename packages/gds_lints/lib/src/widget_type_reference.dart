import 'package:analyzer/dart/element/element.dart';

/// 이름과 선언된 패키지를 기준으로 Dart 타입을 식별하는 객체.
final class WidgetTypeReference {
  const WidgetTypeReference({
    required this.name,
    required this.packageName,
  });

  final String name;
  final String packageName;

  /// [element]가 지정한 패키지와 이름의 위젯인지 확인합니다.
  bool matches(InterfaceElement element) {
    final uri = element.library.uri;

    return element.name == name &&
        uri.scheme == 'package' &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == packageName;
  }
}
