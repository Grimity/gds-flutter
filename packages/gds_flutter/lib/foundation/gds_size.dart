/// 디자인 시스템에서 사용하는 표준 크기.
enum GdsSize {
  xs,
  sm,
  md,
  ml,
  lg,
  xl,
  xxl;

  /// 현재 크기에 대응하는 결과 [T]를 반환합니다.
  T when<T>({
    T? xs,
    T? sm,
    T? md,
    T? ml,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    final value = switch (this) {
      .xs => xs,
      .sm => sm,
      .md => md,
      .ml => ml,
      .lg => lg,
      .xl => xl,
      .xxl => xxl,
    };

    return value ?? (throw StateError('$this 크기에 해당하는 값이 지정되지 않았습니다.'));
  }
}

/// 컴포넌트가 지원하는 [GdsSize] 목록을 선언하는 애너테이션.
final class GdsSupportedSizes {
  const GdsSupportedSizes(this.sizes);

  /// 컴포넌트에서 사용할 수 있는 크기 목록.
  final List<GdsSize> sizes;
}
