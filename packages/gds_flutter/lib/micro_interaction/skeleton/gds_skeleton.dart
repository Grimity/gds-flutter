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
    final effect = ShimmerEffect(
      baseColor: GdsColor.surfaceGraySubtlest.of(context),
      highlightColor: GdsColor.surfaceGraySubtler.of(context),
      duration: const .new(seconds: 1),
    );

    return GdsTransition.crossFade(
      value: enabled,
      child: Skeletonizer(
        enabled: enabled,
        effect: effect,
        child: child,
      ),
    );
  }
}
