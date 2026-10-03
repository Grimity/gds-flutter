import 'package:flutter/widgets.dart';

/// 디자인 시스템에서 사용하는 표준 모서리 반경.
enum GdsRadius {
  none(0),
  xs(4),
  sm(8),
  md(12),
  lg(16),
  xl(20),
  xxl(24),
  full(1e5);

  const new(this.value);

  /// 논리적 픽셀 단위의 모서리 반경.
  final double value;

  // Radius
  Radius get circular => .circular(value);

  // BorderRadius
  BorderRadius get geometry => .circular(value);
}

/// 각 모서리에 적용할 [GdsRadius]를 지정하는 테두리 반경.
class GdsBorderRadius {
  const new({
    this.topLeft = .none,
    this.topRight = .none,
    this.bottomLeft = .none,
    this.bottomRight = .none,
  });

  final GdsRadius topLeft;
  final GdsRadius topRight;
  final GdsRadius bottomLeft;
  final GdsRadius bottomRight;

  BorderRadius get geometry => .only(
    topLeft: topLeft.circular,
    topRight: topRight.circular,
    bottomLeft: bottomLeft.circular,
    bottomRight: bottomRight.circular,
  );
}
