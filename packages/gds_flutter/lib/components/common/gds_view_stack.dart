// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 현재 화면을 별도로 감싸서 사용할 수 있도록 하는 빌더.
typedef GdsViewStackBuilder<T> = Widget Function(BuildContext context, T view);

/// 화면을 추가하고 이전 화면으로 돌아가는 스택 컨트롤러.
class GdsViewStackController<T> extends ChangeNotifier {
  new({required T initialView}) : _views = [initialView];

  /// 현재 추가된 화면 목록.
  final List<T> _views;

  /// 현재 표시하는 화면.
  T get current => _views.last;

  /// 이전 화면으로 돌아갈 수 있는지 여부.
  bool get canPop => _views.length > 1;

  /// 다음 화면을 추가하고 이를 표시합니다.
  void push(T view) {
    _views.add(view);
    notifyListeners();
  }

  /// 이전 화면으로 돌아가며, 돌아갈 수 있는지를 반환합니다.
  bool pop() {
    if (!canPop) return false;
    _views.removeLast();
    notifyListeners();
    return true;
  }
}

/// 스택의 최신 화면을 표시하고 화면 전환 애니메이션을 적용하는 공통 위젯.
class GdsViewStack<T> extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    required this.builder,
  });

  final GdsViewStackController<T> controller;
  final GdsViewStackBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final view = controller.current;

        return PopScope(
          canPop: !controller.canPop,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              controller.pop();
            }
          },
          child: GdsPageTransition(
            child: KeyedSubtree(
              key: ObjectKey(view),
              child: builder(context, view),
            ),
          ),
        );
      },
    );
  }
}
