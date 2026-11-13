// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 모바일에서는 페이지, 태블릿에서는 모달로 표시하는 화면.
abstract class GdsScreen<R> {
  const new();

  /// 페이지의 앱바 또는 모달의 헤더에 표시할 제목.
  String get title;

  /// 본문에 스크롤을 적용할지 여부.
  bool get scroll => true;

  /// 스크롤 영역의 본문에 적용할 안쪽 여백.
  EdgeInsets? get padding => null;

  /// 화면에 표시할 본문과 액션 버튼을 구성합니다.
  R build(BuildContext context);

  /// 모바일에서 표시할 페이지를 구성합니다.
  Widget buildPage(BuildContext context);

  /// 태블릿에서 표시할 모달을 구성합니다.
  GdsModal buildModal(BuildContext context);

  /// 모바일에서는 페이지로 이동하고, 태블릿에서는 모달을 엽니다.
  Future<T?> push<T>(BuildContext context) {
    if (context.isMobile) {
      return context.push(Builder(builder: buildPage));
    } else {
      return GdsModal.show(context, builder: buildModal);
    }
  }

  /// 모바일에서는 페이지를 교체하고, 태블릿에서는 페이지를 닫고 동시에 모달을 엽니다.
  Future<T?> pushReplacement<T>(BuildContext context) {
    if (context.isMobile) {
      return context.pushReplacement(Builder(builder: buildPage));
    } else {
      context.pop();
      return GdsModal.show(context, builder: buildModal);
    }
  }
}
