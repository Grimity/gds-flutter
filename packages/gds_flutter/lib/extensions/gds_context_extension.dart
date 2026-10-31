// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 제공하는 [BuildContext]에 대한 유틸리티 확장.
extension GdsContextExtension on BuildContext {
  /// 앱 화면이 차지하고 있는 크기를 반환합니다.
  Size get viewport => MediaQuery.sizeOf(this);

  /// 화면 가로 너비를 기준으로 기기 유형을 반환합니다.
  GdsDevice get device => GdsDevice.current;

  /// 현재 기기 유형이 모바일인지 여부를 반환합니다.
  bool get isMobile => device == .mobile;

  /// 현재 기기 유형이 태블릿인지 여부를 반환합니다.
  bool get isTablet => device == .tablet;

  /// 화면 가로 너비에 따른 피드 그리드의 열 개수를 반환합니다.
  int get feedGridCrossAxisCount => max(2, viewport.width ~/ 260);

  /// 화면 픽셀 밀도를 고려한 실제 픽셀 단위로 변환합니다.
  double toPhysicalPixels(double pixels) {
    return pixels * MediaQuery.devicePixelRatioOf(this);
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
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// 지정한 위젯을 현재 내비게이터 스택에 푸시합니다.
  Future<T?> push<T>(Widget child) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => child),
    );
  }

  /// 현재 화면을 주어진 위젯으로 교체합니다.
  Future<T?> pushReplacement<T, TO>(Widget child, [TO? result]) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute<T>(builder: (_) => child),
      result: result,
    );
  }

  /// 현재 컨텍스트에서 가장 가까운 [GdsScaffold]의 드로어를 엽니다.
  void openDrawer() => GdsScaffold.openDrawer(this);
}
