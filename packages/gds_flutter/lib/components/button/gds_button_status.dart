/// 버튼의 표시 상태를 나타내는 열거형.
enum GdsButtonStatus {
  enabled,
  disabled,
  loading;

  /// 활성화 및 로딩 여부에 따라 버튼 상태를 반환합니다.
  static GdsButtonStatus from({
    bool enabled = false,
    bool loading = false,
  }) {
    if (loading) return .loading;

    return enabled ? .enabled : .disabled;
  }
}
