import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// Public API에 문서 주석을 작성하도록 안내하는 규칙.
final class ValidPublicMemberDocsRule extends GdsAnalysisRule {
  new()
    : super(
        name: 'valid_public_member_docs',
        description: 'Public API에 문서 주석을 작성하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    'public API에 문서 주석이 없습니다.',
    correctionMessage: '선언 앞에 /// 문서 주석을 작성하세요.',
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    final visitor = _Visitor(this);
    registry
      ..addClassDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor)
      ..addExtensionDeclaration(this, visitor)
      ..addExtensionTypeDeclaration(this, visitor)
      ..addFunctionDeclaration(this, visitor)
      ..addGenericTypeAlias(this, visitor)
      ..addMethodDeclaration(this, visitor)
      ..addMixinDeclaration(this, visitor)
      ..addTopLevelVariableDeclaration(this, visitor);
  }

  /// [node]이 문서화되지 않은 public API 선언이면 경고를 보고합니다.
  void check(AnnotatedNode node, Element? element) {
    if (!_isPublicApi(element) || _isOverride(node) || node.documentationComment != null) return;

    reportAtNode(node);
  }

  /// [node]에 선언된 public 최상위 변수가 있으면 문서 주석 여부를 검사합니다.
  void checkVariables(AnnotatedNode node, VariableDeclarationList variables) {
    final isPublicApi = variables.variables.any((variable) => _isPublicApi(variable.declaredFragment?.element));
    if (node.documentationComment != null || !isPublicApi) return;

    reportAtNode(node);
  }

  /// [element]와 상위 선언이 모두 public인지 여부를 반환합니다.
  bool _isPublicApi(Element? element) {
    if (element?.library?.uri.scheme != 'package') return false;

    while (element != null && element is! LibraryElement) {
      if (!element.isPublic) return false;
      element = element.enclosingElement;
    }

    return element is LibraryElement;
  }

  /// [node]에 @override 어노테이션이 선언되어 있는지 확인합니다.
  bool _isOverride(AnnotatedNode node) {
    return node.metadata.any((annotation) => annotation.name.toSource() == 'override');
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule);

  final ValidPublicMemberDocsRule rule;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // 메인 함수 제외.
    if (node.name.lexeme == 'main') return;

    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.isGetter) return;

    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    rule.check(node, node.declaredFragment?.element);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    rule.checkVariables(node, node.variables);
  }
}
