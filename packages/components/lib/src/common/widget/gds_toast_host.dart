import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';

/// [GdsToast]가 표시될 로컬 오버레이를 제공하는 위젯입니다.
class GdsToastHost extends StatefulWidget {
  const GdsToastHost({super.key, required this.child});

  final Widget child;

  /// 토스트를 표시할 때 사용할 오버레이 컨텍스트입니다.
  static BuildContext? _context;

  /// 현재 등록된 토스트 호스트의 오버레이 컨텍스트를 반환합니다.
  static BuildContext? get context => _context;

  /// 토스트 호스트의 오버레이 컨텍스트를 등록합니다.
  static void attach(BuildContext context) {
    _context = context;
  }

  /// 등록된 토스트 호스트의 오버레이 컨텍스트를 해제합니다.
  static void detach(BuildContext context) {
    if (identical(_context, context)) {
      _context = null;
    }
  }

  @override
  State<GdsToastHost> createState() => _GdsToastHostState();
}

class _GdsToastHostState extends State<GdsToastHost> {
  BuildContext? _overlayContext;

  @override
  void dispose() {
    final overlayContext = _overlayContext;
    if (overlayContext != null) {
      GdsToastHost.detach(overlayContext);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            _overlayContext = context;
            GdsToastHost.attach(context);

            return widget.child;
          },
        ),
      ],
    );
  }
}
