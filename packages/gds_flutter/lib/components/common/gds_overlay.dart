import 'package:flutter/widgets.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [Overlay] 래퍼 위젯.
class GdsOverlay extends StatelessWidget {
  const new({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(builder: (_) => child),
      ],
    );
  }
}
