import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';
import 'package:gds_lints/src/widget_replacement.dart';

/// Flutter 위젯을 대응하는 GDS 위젯으로 대체하도록 안내하는 기본 규칙.
abstract class PreferGdsWidgetRule extends GdsAnalysisRule {
  PreferGdsWidgetRule({
    required super.name,
    required super.description,
  });

  WidgetReplacement get replacement;

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    "Flutter의 '{0}' 위젯 대신 '{1}' 위젯을 사용하세요.",
    correctionMessage: "'{0}' 위젯을 '{1}' 위젯으로 교체하세요.",
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addInstanceCreationExpression(this, _Visitor(this));
  }

  /// [node]가 대체 대상 Flutter 위젯을 생성하는지 확인합니다.
  bool matches(InstanceCreationExpression node) {
    final constructor = node.constructorName.element;
    return constructor != null && replacement.matchesSource(constructor.enclosingElement);
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final PreferGdsWidgetRule rule;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (rule.matches(node)) {
      final sourceName = node.constructorName.element!.enclosingElement.name ?? node.constructorName.type.toSource();
      final targetName = rule.replacement.target.name;

      rule.reportAtNode(
        node.constructorName.type,
        arguments: [sourceName, targetName],
      );
    }
  }
}
