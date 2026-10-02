import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// 컴포넌트에서 지원하는 표준 크기만 사용하도록 안내하는 규칙.
final class ValidGdsSizeRule extends GdsAnalysisRule {
  ValidGdsSizeRule()
    : super(
        name: 'valid_gds_size',
        description: '컴포넌트에서 지원하는 크기를 사용하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    '이 컴포넌트에서 지원하지 않는 크기입니다.',
    correctionMessage: '컴포넌트에서 지원하는 크기로 변경하세요.',
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addArgumentList(this, _Visitor(this));
  }

  /// 전달된 인자가 지원 크기 애너테이션의 적용 대상이면 값의 지원 여부를 검사합니다.
  void check(Argument argument) {
    final parameter = argument.correspondingParameter;
    if (parameter == null || !_isGdsSize(parameter)) return;

    final supportedSizes = _supportedSizes(parameter);
    if (supportedSizes == null) return;

    final size = enumValueName(argument.argumentExpression);

    // 실행 시점에 결정되는 값은 오탐을 방지하기 위해 검사하지 않음.
    if (size == null || supportedSizes.contains(size)) return;

    reportAtNode(argument.argumentExpression);
  }

  /// 매개변수의 선언 타입이 GDS의 [GdsSize]인지 여부를 반환합니다.
  bool _isGdsSize(FormalParameterElement parameter) {
    return isGdsElement(parameter.type.element, name: 'GdsSize');
  }

  /// 매개변수에 적용되는 [GdsSupportedSizes]의 크기 목록을 반환합니다.
  Set<String>? _supportedSizes(FormalParameterElement parameter) {
    final executable = parameter.enclosingElement;
    final owner = executable?.enclosingElement;

    for (final element in [parameter, executable, owner]) {
      final sizes = _supportedSizesOf(element);
      if (sizes != null) return sizes;
    }

    return null;
  }

  /// 선언 요소에 지정된 [GdsSupportedSizes] 애너테이션의 크기 목록을 반환합니다.
  Set<String>? _supportedSizesOf(Element? element) {
    if (element == null) return null;

    for (final annotation in element.baseElement.metadata.annotations) {
      final constructor = annotation.element;
      final type = constructor is ConstructorElement ? constructor.enclosingElement : null;
      if (!isGdsElement(type, name: 'GdsSupportedSizes')) continue;

      return annotation
          .computeConstantValue()
          ?.getField('sizes')
          ?.toListValue()
          ?.map((size) => size.variable?.name)
          .nonNulls
          .toSet();
    }

    return null;
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final ValidGdsSizeRule rule;

  @override
  void visitArgumentList(ArgumentList node) {
    for (final argument in node.arguments) {
      rule.check(argument);
    }
  }
}
