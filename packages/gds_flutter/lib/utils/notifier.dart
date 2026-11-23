import 'package:flutter/widgets.dart';

/// 값을 직접 정의하지 않고 변경 신호를 명시적으로 전달하는 [ChangeNotifier].
/// 외부에서 알림을 발생시켜 구독 중인 서비스나 위젯을 갱신할 때 사용합니다.
class Notifier extends ChangeNotifier {
  /// 등록된 리스너에게 변경 사실을 알립니다.
  void notify() {
    notifyListeners();
  }
}
