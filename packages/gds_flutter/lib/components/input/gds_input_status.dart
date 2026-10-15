/// 입력 필드의 표시 상태를 나타내는 열거형.
/// filled, focused, mention 상태는 내부에서 제어하므로 의도적으로 제외.
enum GdsInputStatus {
  enabled,
  error,
  success,
  disabled;

  /// 활성화 여부에 따라 입력 필드 상태를 반환합니다.
  static GdsInputStatus from({
    bool? enabled,
    bool? error,
    bool? success,
  }) {
    if (enabled == true) return .enabled;
    if (enabled == false) return .disabled;
    if (error == true) return .error;
    if (success == true) return .success;

    return .enabled;
  }
}
