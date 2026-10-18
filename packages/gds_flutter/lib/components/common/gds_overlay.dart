import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Overlay] 래퍼 위젯.
class GdsOverlay extends StatefulWidget {
  const new({
    super.key,
    required this.child,
  });

  final Widget child;

  static final _states = <_State>{};

  /// 현재 라우트에 속하거나 라우트 밖에 있는 오버레이 중 마지막으로 등록된 것을 반환합니다.
  /// 해당 오버레이가 없으면 null을 반환합니다.
  static OverlayState get current {
    for (final state in _states.toList().reversed) {
      final isCurrent = ModalRoute.isCurrentOf(state.context);

      if (state.mounted && isCurrent == true) {
        return state._overlayKey.currentState!;
      }
    }

    // 현재 화면의 오버레이가 없으면 앱 내비게이터를 기준으로.
    final navigatorContext = GdsApp.navigationKey.currentContext;
    if (navigatorContext == null) {
      throw StateError('앱 내비게이터가 위젯 트리에 연결되어 있지 않습니다.');
    }

    return Overlay.of(navigatorContext);
  }

  @override
  State<GdsOverlay> createState() => _State();
}

class _State extends State<GdsOverlay> {
  /// 내부 Overlay의 상태에 접근하기 위한 키.
  final _overlayKey = GlobalKey<OverlayState>();

  /// 자식 위젯을 오버레이의 기본 콘텐츠로 표시하는 엔트리.
  late final _entry = OverlayEntry(builder: (_) => widget.child);

  @override
  void didUpdateWidget(GdsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 부모가 갱신한 자식 위젯을 오버레이에도 반영.
    _entry.markNeedsBuild();
  }

  @override
  void initState() {
    super.initState();
    GdsOverlay._states.add(this);
  }

  @override
  void dispose() {
    GdsOverlay._states.remove(this);
    _entry.remove();
    _entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(key: _overlayKey, initialEntries: [_entry]);
  }
}
