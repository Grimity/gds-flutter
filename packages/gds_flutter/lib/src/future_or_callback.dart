import 'dart:async';

import 'package:pervice/pervice.dart';

/// 동기 또는 비동기 작업을 실행하는 콜백.
typedef FutureOrCallback = FutureOr<void> Function();

/// 콜백 실행과 로딩 상태 관리를 위한 확장.
extension FutureOrCallbackExtension on FutureOrCallback {
  /// 콜백을 실행하고, 비동기 작업이면 로딩 상태로 전환합니다.
  void run(ValueState<bool> loading) {
    final result = this();

    if (result is Future) {
      loading.run(() async => await result);
    }
  }
}
