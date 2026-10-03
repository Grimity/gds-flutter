import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// 생성자 선언에서 식별자 이름을 반복하지 않도록 안내하는 규칙.
final class PreferConciseConstructorRule extends GdsAnalysisRule {
  new()
    : super(
        name: 'prefer_concise_constructor',
        description: '생성자 선언에는 더 간결한 문법을 사용하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    '생성자 선언에 식별자 이름을 반복하지 마세요.',
    correctionMessage: '일반 생성자는 new, 팩토리 생성자는 factory를 사용하세요.',
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addConstructorDeclaration(this, _Visitor(this));
  }

  /// 기존 문법으로 선언된 생성자의 이름을 보고합니다.
  void check(ConstructorDeclaration node) {
    final typeName = node.typeName;

    // 타입 이름이 없으면 생략된 것을 의미하므로 통과.
    if (typeName == null) return;

    reportAtNode(typeName);
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final PreferConciseConstructorRule rule;

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    rule.check(node);
  }
}
