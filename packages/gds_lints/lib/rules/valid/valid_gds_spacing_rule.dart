import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// 디자인 시스템에서 지원하는 표준 간격 값만 사용하도록 안내하는 규칙.
final class ValidGdsSpacingRule extends GdsAnalysisRule {
  new()
    : super(
        name: 'valid_gds_spacing',
        description: '디자인 시스템에서 지원하는 간격 값을 사용하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    '디자인 시스템에서 지원하지 않는 간격 값입니다.',
    correctionMessage: '디자인 시스템에서 지원하는 간격 값으로 변경하세요.',
  );

  /// 디자인 시스템에서 지원하는 간격 값 목록.
  final spacings = <double>{
    2, 4, 6, 8, 10, 12, 16, 20, 24, //
    28, 32, 36, 40, 48, 56, 64, 72,
  };

  /// 해당 값은 [GdsNumberExtension]에서 수정될 때 똑같이 수정해야 합니다.
  static const _spacingGetters = {
    'all',
    'vertical',
    'horizontal',
    'top',
    'left',
    'right',
    'bottom',
    'verticalGap',
    'horizontalGap',
  };

  /// Flutter 위젯 타입별로 간격을 지정하는 매개변수 이름.
  static const _spacingParameters = {
    'Row': {'spacing'},
    'Column': {'spacing'},
    'Wrap': {'spacing', 'runSpacing'},
    'EdgeInsets': {'value', 'horizontal', 'vertical', 'left', 'top', 'right', 'bottom'},
    'EdgeInsetsGeometry': {'value', 'horizontal', 'vertical', 'left', 'top', 'right', 'bottom', 'start', 'end'},
    'EdgeInsetsDirectional': {'value', 'horizontal', 'vertical', 'start', 'top', 'end', 'bottom'},
  };

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    final visitor = _Visitor(this);
    registry
      ..addArgumentList(this, visitor)
      ..addPrefixedIdentifier(this, visitor)
      ..addPropertyAccess(this, visitor);
  }

  /// 전달된 인자가 간격 매개변수라면 값의 지원 여부를 검사합니다.
  void check(Argument argument) {
    final parameter = argument.correspondingParameter;
    if (parameter == null || !_isSpacingParameter(parameter)) return;

    _reportIfUnsupported(argument.argumentExpression);
  }

  /// [GdsNumberExtension]으로 생성하는 여백과 간격 값의 지원 여부를 검사합니다.
  void checkExtension(Expression target, SimpleIdentifier getter) {
    final element = getter.element;
    if (element == null ||
        !isGdsElement(element) ||
        element.enclosingElement?.name != 'GdsNumberExtension' ||
        !_spacingGetters.contains(getter.name)) {
      return;
    }

    _reportIfUnsupported(target);
  }

  /// 상수로 계산할 수 있는 값이 표준 간격에 포함되지 않으면 이를 보고합니다.
  void _reportIfUnsupported(Expression expression) {
    final constant = constantValue(expression);
    final value = constant?.toDoubleValue() ?? constant?.toIntValue()?.toDouble();

    // 실행 시점에 결정되는 값은 오탐을 방지하기 위해 검사하지 않음.
    if (value == null || value == 0 || spacings.contains(value)) return;

    reportAtNode(expression);
  }

  /// 매개변수가 디자인 시스템 또는 Flutter에서 정의한 간격 값인지 확인합니다.
  bool _isSpacingParameter(FormalParameterElement parameter) {
    if (_isGdsSpacing(parameter)) return true;

    final executable = parameter.enclosingElement;
    final interface = executable?.enclosingElement;
    if (interface is! InterfaceElement) {
      return false;
    }

    if (!isPackageElement(interface, packageName: 'flutter')) return false;

    return _spacingParameters[interface.name]?.contains(parameter.name) ?? false;
  }

  /// 매개변수의 선언 타입이 GDS의 [GdsSpacing]인지 여부를 반환합니다.
  bool _isGdsSpacing(FormalParameterElement parameter) {
    final alias = parameter.type.alias?.element;
    return isGdsElement(alias, name: 'GdsSpacing');
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final ValidGdsSpacingRule rule;

  @override
  void visitArgumentList(ArgumentList node) {
    for (final argument in node.arguments) {
      rule.check(argument);
    }
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    rule.checkExtension(node.prefix, node.identifier);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    final target = node.target;
    if (target != null) {
      rule.checkExtension(target, node.propertyName);
    }
  }
}
