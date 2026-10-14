/// 입력 필드의 표시 상태를 나타내는 열거형.
/// filled, focused, mention 상태는 내부에서 제어하므로 의도적으로 제외.
enum GdsInputStatus {
  enabled,
  error,
  success,
  disabled;

  /// 활성화 여부에 따라 입력 필드 상태를 반환합니다.
  static GdsInputStatus from({
    bool enabled = false,
    bool error = false,
    bool success = false,
  }) {
    if (!enabled) return .disabled;
    if (error) return .error;
    if (success) return .success;

    return .enabled;
  }
}
