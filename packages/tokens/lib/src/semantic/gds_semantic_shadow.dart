import 'package:flutter/widgets.dart';

/// Light Mode 전용이며, Dark Mode 값은 별도로 정의하지 않았습니다.
class GdsSemanticShadow {
  const GdsSemanticShadow._();

  static const List<BoxShadow> level1 = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
      color: Color(0x14000000), // Color(0xFF000000).withValues(alpha: 0.08),
    ),
  ];

  static const List<BoxShadow> level2 = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 10,
      spreadRadius: 0,
      color: Color(0x1A000000), // Color(0xFF000000).withValues(alpha: 0.1),
    ),
  ];
}
