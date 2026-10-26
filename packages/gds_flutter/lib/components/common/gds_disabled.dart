import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 비활성화 시 자식 위젯을 반투명하게 하고 포인터 입력을 차단하는 위젯.
class GdsDisabled extends StatelessWidget {
  const new({
    super.key,
    this.animation = .normal,
    required this.enabled,
    required this.child,
  });

  final GdsAnimation animation;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1 : 0.5,
      duration: animation.duration,
      curve: animation.curve,
      child: IgnorePointer(
        ignoring: !enabled,
        child: child,
      ),
    );
  }
}

/// 비활성화 시 슬리버를 반투명하게 표시하고 사용자 입력을 차단하는 위젯.
class GdsSliverDisabled extends StatelessWidget {
  const new({
    super.key,
    this.animation = .normal,
    required this.enabled,
    required this.sliver,
  });

  final GdsAnimation animation;
  final bool enabled;
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedOpacity(
      opacity: enabled ? 1 : 0.5,
      duration: animation.duration,
      curve: animation.curve,
      sliver: SliverIgnorePointer(
        ignoring: !enabled,
        sliver: sliver,
      ),
    );
  }
}
