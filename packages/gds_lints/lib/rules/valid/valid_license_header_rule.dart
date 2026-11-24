// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:gds_lints/src/gds_analysis_rule.dart';

/// Dart 파일 최상단에 공통 라이선스 헤더를 작성하도록 안내하는 규칙.
final class ValidLicenseHeaderRule extends GdsAnalysisRule {
  new()
    : super(
        name: 'valid_license_header',
        description: '파일 최상단에 Grimity 라이선스 헤더를 작성하세요.',
      );

  /// 파일에 포함해야 하는 라이선스 헤더.
  static const header =
      '// Copyright © 2026 Grimity. All rights reserved.\n'
      '// Licensed under the Grimity Source-Available License v1.0.\n'
      '// AI/ML training and dataset use are prohibited. See LICENSE.';

  @override
  DiagnosticCode get diagnosticCode => LintCode(
    name,
    '파일 최상단에 Grimity 라이선스 헤더가 없습니다.',
    correctionMessage: '공통 라이선스 헤더 3줄을 추가하세요.',
    severity: .WARNING,
  );

  @override
  bool get canUseParsedResult => true;

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addCompilationUnit(this, _Visitor(this, context));
  }

  /// 파일 시작 부분에 완전한 라이선스 헤더가 있는지 검사합니다.
  void check(String content) {
    final text = content.replaceAll('\r\n', '\n');

    if (!text.startsWith(header)) {
      reportAtOffset(0, content.isEmpty ? 0 : 1);
    }
  }
}

final class _Visitor extends SimpleAstVisitor<void> {
  new(this.rule, this.context);

  final ValidLicenseHeaderRule rule;
  final RuleContext context;

  @override
  void visitCompilationUnit(CompilationUnit node) {
    rule.check(context.currentUnit!.content);
  }
}
