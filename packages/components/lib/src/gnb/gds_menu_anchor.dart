import 'package:flutter/widgets.dart';

/// 전달받은 [LayerLink]는 메뉴를 오버레이에 표시할 때 함께 사용합니다.
typedef GdsMenuAnchorBuilder = Widget Function(LayerLink link);

/// 메뉴가 따라붙을 기준 위치를 제공하는 위젯입니다.
class GdsMenuAnchor extends StatefulWidget {
  const GdsMenuAnchor({super.key, required this.builder});

  /// 참고: [LayerLink]를 전달받아 기준 위젯을 빌드하도록 함.
  final GdsMenuAnchorBuilder builder;

  @override
  State<GdsMenuAnchor> createState() => _GdsMenuAnchorState();
}

class _GdsMenuAnchorState extends State<GdsMenuAnchor> {
  final link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: widget.builder(link),
    );
  }
}
