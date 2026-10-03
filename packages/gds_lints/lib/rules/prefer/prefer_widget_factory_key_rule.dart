import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// 위젯을 반환하는 정적 메서드에서 Key를 받아 사용하도록 안내하는 규칙.
final class PreferWidgetFactoryKeyRule extends GdsAnalysisRule {
  new()
    : super(
        name: 'prefer_widget_factory_key',
        description: '위젯을 반환하는 정적 메서드에서 Key 매개변수를 받아 사용하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    '위젯을 반환하는 정적 메서드는 Key 매개변수를 받아 본문에서 사용해야 합니다.',
    correctionMessage: 'Key 매개변수를 선언하고 반환할 위젯에 전달하세요.',
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addMethodDeclaration(this, _Visitor(this));
  }

  /// 위젯 팩터리가 Key 매개변수를 선언하고 본문에서 참조하는지 검사합니다.
  void check(MethodDeclaration node) {
    if (!node.isStatic || node.isGetter || node.isSetter || node.body is EmptyFunctionBody) return;

    final element = node.declaredFragment?.element;
    if (element == null || !_isFlutterType(element.returnType, name: 'Widget')) return;

    final keys = element.formalParameters.where((parameter) => _isFlutterType(parameter.type, name: 'Key')).toSet();
    if (keys.isNotEmpty) {
      final visitor = _KeyUsageVisitor(keys);
      node.body.accept(visitor);
      if (visitor.isUsed) return;
    }

    reportAtToken(node.name);
  }

  /// 타입이 지정한 Flutter 타입 또는 그 하위 타입인지 여부를 반환합니다.
  bool _isFlutterType(DartType type, {required String name}) {
    if (type is TypeParameterType) return _isFlutterType(type.bound, name: name);
    if (type is! InterfaceType) return false;

    return isPackageElement(type.element, packageName: 'flutter', name: name) ||
        type.allSupertypes.any((type) => isPackageElement(type.element, packageName: 'flutter', name: name));
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final PreferWidgetFactoryKeyRule rule;

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    rule.check(node);
  }
}

/// 이름이 같은 지역 변수와 혼동하지 않도록 매개변수 요소를 기준으로 참조를 찾습니다.
final class _KeyUsageVisitor extends RecursiveAstVisitor<void> {
  new(this.keys);

  final Set<FormalParameterElement> keys;
  bool isUsed = false;

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (keys.contains(node.element)) isUsed = true;
  }
}
