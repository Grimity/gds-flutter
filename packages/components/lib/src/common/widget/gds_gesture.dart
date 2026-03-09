import 'package:flutter/widgets.dart';

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
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.child,
  });

  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final Widget? child;

  /// 자식의 실제 페인트 여부와 관계없이 레이아웃 영역 전체를 터치 영역으로 취급합니다.
  static const HitTestBehavior hitTestBehavior = HitTestBehavior.opaque;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: hitTestBehavior,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: child,
    );
  }
}
