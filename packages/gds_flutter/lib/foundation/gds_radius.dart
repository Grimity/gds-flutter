/// 디자인 시스템에서 사용하는 표준 모서리 반경.
enum GdsRadius {
  xs(4),
  sm(8),
  md(12),
  lg(16),
  xl(20),
  xxl(24),
  full(1e5);

  const GdsRadius(this.value);

  /// 논리적 픽셀 단위의 모서리 반경.
  final double value;
}
