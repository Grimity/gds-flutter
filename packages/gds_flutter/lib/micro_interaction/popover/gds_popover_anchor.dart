import 'package:flutter/widgets.dart';

/// 팝오버와 연결할 [LayerLink]를 전달받아 기준 위젯을 빌드하는 함수.
typedef GdsPopoverAnchorBuilder = Widget Function(BuildContext context, LayerLink link);

/// 팝오버가 따라갈 기준 위젯을 만들고 [LayerLink]를 제공하는 위젯.
class GdsPopoverAnchor extends StatefulWidget {
  const GdsPopoverAnchor({
    super.key,
    required this.builder,
  });

  /// [LayerLink]를 전달받아 기준 위젯을 빌드하는 빌더.
  final GdsPopoverAnchorBuilder builder;

  @override
  State<GdsPopoverAnchor> createState() => _GdsPopoverAnchorState();
}

class _GdsPopoverAnchorState extends State<GdsPopoverAnchor> {
  final link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: widget.builder(context, link),
    );
  }
}
