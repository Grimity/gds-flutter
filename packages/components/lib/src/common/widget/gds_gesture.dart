import 'package:flutter/widgets.dart';
import 'package:flutter_touch_scale/flutter_touch_scale.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 제스처 래퍼입니다.
///
/// 기본 `GestureDetector` 대신 사용해 hit test 동작을 일관되게 맞춥니다.
/// `HitTestBehavior.opaque`를 고정해 자식이 투명하거나 빈 영역이 있어도
/// 위젯이 차지하는 영역 전체에서 탭 이벤트를 받을 수 있게 합니다.
class GdsGesture extends StatelessWidget {
  const GdsGesture({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.child,
    this.useEffect = true,
  });

  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final Widget? child;

  /// 터치 효과를 사용할지 여부입니다.
  final bool useEffect;

  /// 자식의 실제 페인트 여부와 관계없이 레이아웃 영역 전체를 터치 영역으로 취급합니다.
  static const HitTestBehavior hitTestBehavior = HitTestBehavior.opaque;

  @override
  Widget build(BuildContext context) {
    if (useEffect && onTap != null) {
      assert(child != null, 'onTap이 제공된 경우 child는 null이 될 수 없습니다.');
      assert(onDoubleTap == null, 'onTap과 onDoubleTap은 동시에 사용할 수 없습니다.');
      assert(onLongPress == null, 'onTap과 onLongPress는 동시에 사용할 수 없습니다.');
      assert(onHorizontalDragStart == null, 'onTap과 onHorizontalDragStart는 동시에 사용할 수 없습니다.');
      assert(onHorizontalDragUpdate == null, 'onTap과 onHorizontalDragUpdate는 동시에 사용할 수 없습니다.');
      assert(onHorizontalDragEnd == null, 'onTap과 onHorizontalDragEnd는 동시에 사용할 수 없습니다.');
      assert(onHorizontalDragCancel == null, 'onTap과 onHorizontalDragCancel은 동시에 사용할 수 없습니다.');

      return TouchScale(
        onPress: onTap!,
        scale: 1.5,
        curve: const Cubic(0.25, 0.15, 0.2, 1.0),
        child: child!,
      );
    }

    return GestureDetector(
      behavior: hitTestBehavior,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: child,
    );
  }
}
