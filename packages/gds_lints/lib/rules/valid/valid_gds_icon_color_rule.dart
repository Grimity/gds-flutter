import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// 시맨틱 아이콘에 색상을 명시하도록 안내하는 규칙.
final class ValidGdsIconColorRule extends GdsAnalysisRule {
  new()
    : super(
        name: 'valid_gds_icon_color',
        description: '시맨틱 GdsIcon을 생성할 때 색상을 지정하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    '시맨틱 GdsIcon은 색상을 명시해야 합니다.',
    correctionMessage: 'color 인자에 GdsColor 값을 지정하세요.',
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addMethodInvocation(this, _Visitor(this));
  }

  /// 시맨틱 아이콘에 색상이 지정되었는지 검사합니다.
  void check(MethodInvocation invocation) {
    final target = invocation.realTarget;
    if (target == null || invocation.methodName.name != 'build') return;

    final method = invocation.methodName.element;
    if (!isGdsElement(method) || method?.enclosingElement?.name != 'GdsIcon') return;

    final type = constantValue(target)?.getField('type')?.variable?.name;

    // 아이콘 유형이 시맨틱인 경우
    if (type == 'semantic') {
      final color = namedArgument(invocation.argumentList, 'color');
      if (color != null && !isNullConstant(color.argumentExpression)) return;

      reportAtNode(invocation.methodName);
    }
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final ValidGdsIconColorRule rule;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.check(node);
  }
}
