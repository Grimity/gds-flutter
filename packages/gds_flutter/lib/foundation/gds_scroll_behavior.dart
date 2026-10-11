import 'package:flutter/material.dart';
import 'package:gds_flutter/foundation/gds_scroll_physics.dart';

/// 디자인 시스템에서 사용하며 Android에서는 커스텀 스크롤 물리를 적용하는 설정.
class GdsScrollBehavior extends MaterialScrollBehavior {
  const new();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    if (getPlatform(context) == .android) {
      return const GdsScrollPhysics();
    }

    return super.getScrollPhysics(context);
  }
}
