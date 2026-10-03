import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

/// 디자인 시스템 애널라이저에서 공통으로 사용하는 기능을 제공하는 기본 클래스.
abstract class GdsAnalysisRule extends AnalysisRule {
  new({
    required super.name,
    required super.description,
  });

  /// 요소가 지정한 패키지에서 선언된 지정 요소인지 여부를 반환합니다.
  bool isPackageElement(
    Element? element, {
    required String packageName,
    String? name,
  }) {
    final uri = element?.library?.uri;

    return (name == null || element?.name == name) &&
        uri?.scheme == 'package' &&
        uri?.pathSegments.firstOrNull == packageName;
  }

  /// 요소가 gds_flutter 패키지에서 선언된 지정 요소인지 여부를 반환합니다.
  bool isGdsElement(Element? element, {String? name}) {
    return isPackageElement(
      element,
      packageName: 'gds_flutter',
      name: name,
    );
  }

  /// 호출에 주어진 이름으로 전달된 인자를 반환합니다.
  NamedArgument? namedArgument(ArgumentList arguments, String name) {
    for (final argument in arguments.arguments) {
      if (argument is NamedArgument && argument.name.lexeme == name) {
        return argument;
      }
    }

    return null;
  }

  /// 표현식을 상수로 계산한 값을 반환합니다.
  DartObject? constantValue(Expression expression) {
    return expression.computeConstantValue()?.value;
  }

  /// enum 상수 표현식의 이름을 반환합니다.
  String? enumValueName(Expression expression) {
    return constantValue(expression)?.variable?.name;
  }

  /// 표현식이 null 상수인지 여부를 반환합니다.
  bool isNullConstant(Expression expression) {
    return constantValue(expression)?.isNull ?? false;
  }
}
