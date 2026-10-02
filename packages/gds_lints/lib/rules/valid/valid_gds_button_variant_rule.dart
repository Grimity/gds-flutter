import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// 텍스트 버튼 유형에 맞게 variant를 지정하도록 안내하는 규칙.
final class ValidGdsButtonVariantRule extends GdsAnalysisRule {
  ValidGdsButtonVariantRule()
    : super(
        name: 'valid_gds_button_variant',
        description: '선택한 GdsTextButtonType에 맞게 variant를 지정하세요.',
      );

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    'variant 인자가 선택한 버튼 유형에 맞지 않습니다.',
    correctionMessage: '버튼 유형에 맞게 variant 인자를 추가하거나 제거하세요.',
  );

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addArgumentList(this, _Visitor(this));
  }

  /// [GdsButton.text] 호출의 type과 variant 조합이 유효한지 검사합니다.
  void check(ArgumentList arguments) {
    final type = namedArgument(arguments, 'type');
    if (type == null || !_isGdsButtonText(type)) return;

    final supportsVariant = _supportsVariant(type.argumentExpression);
    if (supportsVariant == null) return;

    final variant = namedArgument(arguments, 'variant');
    final invalid = supportsVariant ? variant == null || isNullConstant(variant.argumentExpression) : variant != null;
    if (!invalid) return;

    reportAtNode(variant?.argumentExpression ?? type.argumentExpression);
  }

  /// type 인자가 [GdsButton.text]의 매개변수에 전달되는지 여부를 반환합니다.
  bool _isGdsButtonText(NamedArgument type) {
    final executable = type.correspondingParameter?.enclosingElement;
    final owner = executable?.enclosingElement;

    return executable?.name == 'text' && isGdsElement(owner, name: 'GdsButton');
  }

  /// 버튼 유형 상수의 스타일 구성을 기준으로 variant 지원 여부를 반환합니다.
  bool? _supportsVariant(Expression expression) {
    final value = constantValue(expression);
    if (value == null) return null;

    final primary = value.getField('primary');
    final assistive = value.getField('assistive');
    if (primary == null || assistive == null) return null;

    return !primary.isNull || !assistive.isNull;
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final ValidGdsButtonVariantRule rule;

  @override
  void visitArgumentList(ArgumentList node) {
    rule.check(node);
  }
}
