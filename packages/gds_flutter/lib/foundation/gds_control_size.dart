/// 디자인 시스템 내 인터랙티브 컴포넌트(버튼, 입력창 등)에서 사용하는 고정 크기.
enum GdsControlSize {
  none(null),
  xl(56),
  lg(52),
  ml(48),
  md(42),
  sm(32),
  xs(24);

  const new(this.value);

  /// 현재 크기에 대응하는 높이 값.
  final double? value;
}
