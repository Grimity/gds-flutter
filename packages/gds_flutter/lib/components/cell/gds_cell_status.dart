/// 셀 아이템의 표시 상태를 나타내는 열거형.
enum GdsCellStatus {
  enabled,
  selected,
  disabled,
  negative;

  /// 활성화 여부에 따라 셀 상태를 반환합니다.
  static GdsCellStatus from({
    bool enabled = false,
    bool selected = false,
    bool negative = false,
  }) {
    if (!enabled) return .disabled;
    if (negative) return .negative;
    if (selected) return .selected;

    return .enabled;
  }
}
