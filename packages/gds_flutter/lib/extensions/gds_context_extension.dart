import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [BuildContext]에 대한 유틸리티 확장.
extension GdsContextExtension on BuildContext {
  /// 앱 화면이 차지하고 있는 크기를 반환합니다.
  Size get viewport => MediaQuery.of(this).size;

  /// 화면 가로 너비를 기준으로 기기 유형을 반환합니다.
  GdsDevice get device => .fromWidth(viewport.width);

  /// 현재 기기 유형이 모바일인지 여부를 반환합니다.
  bool get isMobile => device == .mobile;

  /// 현재 기기 유형이 태블릿인지 여부를 반환합니다.
  bool get isTablet => device == .tablet;

  /// 화면 픽셀 밀도를 고려한 실제 픽셀 단위로 변환합니다.
  double toPhysicalPixels(double pixels) {
    final dpr = MediaQuery.of(this).devicePixelRatio;
    return pixels * dpr;
  }

  /// 현재 기기 유형에 대응하는 콜백을 실행하고 결과를 반환합니다.
  T whenDevice<T>({
    required T mobile,
    required T tablet,
  }) => switch (device) {
    .mobile => mobile,
    .tablet => tablet,
  };

  /// 현재 컨텍스트에 설정된 테마를 반환합니다.
  GdsTheme get theme => GdsThemeScope.of(this);

  /// 현재 라우트를 닫고 이전 화면으로 돌아갑니다.
  void pop<T>() => Navigator.of(this).pop<T>();

  /// 지정한 [route]를 현재 내비게이터 스택에 푸시합니다.
  void push<T>(Route<T> route) => Navigator.of(this).push<T>(route);
}
