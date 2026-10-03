import 'package:flutter/animation.dart';

/// 디자인 시스템에서 사용하는 표준 애니메이션 속도.
enum GdsAnimation {
  fast(.new(milliseconds: 150)),
  normal(.new(milliseconds: 200)),
  slow(.new(milliseconds: 275)),
  slowest(.new(milliseconds: 350));

  const new(this.duration);

  /// 애니메이션 지속 시간.
  final Duration duration;

  /// 애니메이션에 적용되는 곡선.
  Curve get curve => Curves.ease;
}
