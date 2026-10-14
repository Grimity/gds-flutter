import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 팝오버와 연결할 [LayerLink]를 전달받아 기준 위젯을 빌드하는 함수.
typedef GdsPopoverAnchorBuilder = Widget Function(
  BuildContext context,
  LayerLink layerLink,
);

/// [LayerLink]가 지정된 경우 자식을 팝오버의 위치 기준 대상으로 연결하는 위젯.
class GdsPopoverAnchor extends StatelessWidget {
  const new({
    super.key,
    this.layerLink,
    required this.child,
  });

  final LayerLink? layerLink;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (layerLink != null) {
      return CompositedTransformTarget(
        link: layerLink!,
        child: child,
      );
    }

    return child;
  }

  /// [LayerLink]를 관리하고 빌더의 자식을 팝오버 기준 대상으로 연결하는 빌더.
  static Widget builder({
    Key? key,
    required GdsPopoverAnchorBuilder builder,
  }) {
    return Builder(
      key: key,
      builder: (context) {
        final layerLink = context.useLayerLink();

        return GdsPopoverAnchor(
          layerLink: layerLink,
          child: builder(context, layerLink),
        );
      },
    );
  }
}
