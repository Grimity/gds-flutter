// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:gds_lints/rules/valid/valid_license_header_rule.dart';

/// 파일 맨 위에 공통 라이선스 헤더를 추가하는 빠른 수정.
final class AddLicenseHeader extends ResolvedCorrectionProducer {
  new({required super.context});

  @override
  CorrectionApplicability get applicability => .singleLocation;

  @override
  FixKind get fixKind => const FixKind(
    'gds.fix.addLicenseHeader',
    DartFixKindPriority.standard,
    '라이선스 헤더 추가',
  );

  @override
  Future<void> compute(ChangeBuilder builder) async {
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleInsertion(0, '${ValidLicenseHeaderRule.header}\n\n');
    });
  }
}
