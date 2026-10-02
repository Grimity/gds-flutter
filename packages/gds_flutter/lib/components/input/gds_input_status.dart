/// 입력 필드의 표시 상태를 나타내는 열거형.
/// filled, focused, mention 상태는 내부에서 제어하므로 의도적으로 제외.
enum GdsInputStatus {
  enabled,
  error,
  success,
  disabled,
}
