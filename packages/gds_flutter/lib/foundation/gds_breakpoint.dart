/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=9276-204266&m=dev
enum GdsBreakpoint {
  xs(0, 767),
  sm(768, 991),
  md(992, 1199),
  lg(1200, 1599),
  xl(1600, double.infinity);

  const GdsBreakpoint(
    this.minWidth,
    this.maxWidth,
  );

  final double minWidth;
  final double maxWidth;

  /// 주어진 가로 크기에 부합하는 [GdsBreakpoint]을 반환합니다.
  static GdsBreakpoint fromWidth(double width) {
    assert(width > 0, '가로 크기는 음수일 수 없습니다.');

    return GdsBreakpoint.values.firstWhere(
      (breakpoint) => width >= breakpoint.minWidth && width <= breakpoint.maxWidth,
    );
  }
}
