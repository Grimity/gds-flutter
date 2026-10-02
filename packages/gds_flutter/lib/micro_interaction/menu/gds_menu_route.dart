import 'package:gds_flutter/gds_flutter.dart';

/// 기준 위젯 아래에 [GdsMenu]를 표시하는 팝오버 라우트입니다.
class GdsMenuRoute<T> extends GdsPopoverRoute<T> {
  GdsMenuRoute({
    required GdsMenuPosition position,
    required super.layerLink,
    required GdsMenu child,
  }) : super(
         followerAnchor: position.followerAnchor,
         targetAnchor: position.targetAnchor,
         offset: const .new(0, 8),
         child: child,
       );
}
