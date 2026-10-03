// ignore_for_file: gds_lints/prefer_gds_gesture

import 'package:flutter/widgets.dart';
import 'package:flutter_touch_scale/flutter_touch_scale.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 제스처 래퍼 위젯.
class GdsGesture extends StatelessWidget {
  const new({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.cursor = SystemMouseCursors.click,
    this.child,
    this.useEffect = true,
  });

  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final MouseCursor cursor;
  final Widget? child;

  /// 터치 효과를 사용할지 여부.
  final bool useEffect;

  /// 자식의 실제 페인트 여부와 관계없이 레이아웃 영역 전체를 터치 영역으로 취급.
  static const hitTestBehavior = HitTestBehavior.opaque;

  @override
  Widget build(BuildContext context) {
    final MouseCursor cursor = onTap == null ? .defer : this.cursor;

    if (useEffect) {
      assert(child != null, 'onTap이 제공된 경우 child는 null이 될 수 없습니다.');
      assert(onDoubleTap == null, 'onTap과 onDoubleTap은 동시에 사용할 수 없습니다.');
      assert(onLongPress == null, 'onTap과 onLongPress는 동시에 사용할 수 없습니다.');

      return MouseRegion(
        cursor: cursor,
        child: TouchScale(
          onPress: onTap,
          scale: 1.5,
          curve: const Cubic(0.25, 0.15, 0.2, 1.0),
          child: child!,
        ),
      );
    }

    return MouseRegion(
      cursor: onTap == null ? .defer : cursor,
      child: GestureDetector(
        behavior: hitTestBehavior,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
