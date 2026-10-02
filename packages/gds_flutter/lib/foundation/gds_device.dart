import 'package:gds_flutter/gds_flutter.dart';

/// 화면 가로 너비를 기준으로 분류한 기기 유형.
enum GdsDevice {
  mobile,
  tablet;

  /// 주어진 화면 가로 너비에 해당하는 기기 유형을 반환합니다.
  static GdsDevice fromWidth(double width) {
    return switch (GdsBreakpoint.fromWidth(width)) {
      .xs => .mobile,
      .sm => .tablet,
      .md => .tablet,
      .lg => .tablet,
      .xl => .tablet,
    };
  }
}
