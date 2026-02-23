import 'package:flutter/widgets.dart';
import 'package:gds_tokens/gds_tokens.dart';

/// Grimity Design System 그림자
///
/// ## 사용 예시
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: GdsShadows.level1,
///   ),
/// )
/// ```
class GdsShadows {
  const GdsShadows._();

  static const List<BoxShadow> level1 = GdsSemanticShadow.level1;

  static const List<BoxShadow> level2 = GdsSemanticShadow.level2;
}
