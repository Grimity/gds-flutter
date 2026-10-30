import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// 자식 위젯을 스켈레톤 UI 형태로 표시하는 로딩 위젯.
class GdsSkeleton extends StatelessWidget {
  const new({
    super.key,
    this.enabled = true,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effect = createEffect(context);

    return Skeletonizer(
      enabled: enabled,
      effect: effect,
      child: child,
    );
  }

  /// 현재 테마에 대응하는 스켈레톤 효과를 생성합니다.
  static ShimmerEffect createEffect(BuildContext context) {
    return ShimmerEffect(
      baseColor: GdsColor.surfaceGraySubtlest.of(context),
      highlightColor: GdsColor.surfaceGraySubtler.of(context),
      duration: const .new(seconds: 1),
    );
  }
}

/// 자식 위젯을 스켈레톤 UI 형태로 표시하는 로딩 슬리버.
class GdsSliverSkeleton extends StatelessWidget {
  const new({
    super.key,
    this.enabled = true,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effect = GdsSkeleton.createEffect(context);

    return Skeletonizer.sliver(
      enabled: enabled,
      effect: effect,
      child: child,
    );
  }
}
