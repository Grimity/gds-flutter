import 'package:flutter/widgets.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Overlay] 래퍼 위젯.
class GdsOverlay extends StatefulWidget {
  const new({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GdsOverlay> createState() => _State();
}

class _State extends State<GdsOverlay> {
  late final _entry = OverlayEntry(builder: (_) => widget.child);

  @override
  void didUpdateWidget(GdsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 부모가 갱신한 자식 위젯을 오버레이에도 반영.
    _entry.markNeedsBuild();
  }

  @override
  void dispose() {
    _entry.remove();
    _entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(initialEntries: [_entry]);
  }
}
