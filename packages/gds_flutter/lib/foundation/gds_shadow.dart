import 'package:flutter/widgets.dart';

/// 디자인 시스템에서 사용하는 표준 그림자.
enum GdsShadow {
  level1(
    x: 0,
    y: 2,
    blur: 6,
    spread: 0,
    color: Color(0x14000000),
  ),
  level2(
    x: 0,
    y: 4,
    blur: 10,
    spread: 0,
    color: Color(0x1A000000),
  );

  const GdsShadow({
    required this.x,
    required this.y,
    required this.blur,
    required this.spread,
    required this.color,
  });

  final double x;
  final double y;
  final double blur;
  final double spread;
  final Color color;

  /// 도형 바깥쪽에 표시할 [BoxShadow]를 반환합니다.
  BoxShadow get outer => .new(
    offset: Offset(x, y),
    color: color,
    blurStyle: .outer,
    blurRadius: blur,
    spreadRadius: spread,
  );
}
