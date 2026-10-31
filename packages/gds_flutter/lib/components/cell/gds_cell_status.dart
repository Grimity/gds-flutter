// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

/// 셀 아이템의 표시 상태를 나타내는 열거형.
enum GdsCellStatus {
  enabled,
  selected,
  disabled,
  negative;

  /// 활성화 여부에 따라 셀 상태를 반환합니다.
  static GdsCellStatus from({
    bool? enabled,
    bool? selected,
    bool? negative,
  }) {
    if (enabled == false) return .disabled;
    if (negative == true) return .negative;
    if (selected == true) return .selected;

    return .enabled;
  }
}
