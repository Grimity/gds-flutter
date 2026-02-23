part of '../gds_lottie.dart';

/// Grimity Design System Lottie
///
/// lottie json 위젯으로 빌드하는 enum.
///
/// ## 사용 예시
/// ```dart
/// // 기본 사용 (24x24)
/// GdsLottie.circularLoadingBasic.build()
///
/// // 사이즈 지정
/// GdsLottie.circularLoadingBasic.build(
///   width: GdsAtomicIconSize.v24,
///   height: GdsAtomicIconSize.v24,
/// )
/// ```
///
enum GdsLottie implements LottieBuilder {
  circularLoadingBasic(path: 'assets/lottie/circular_loading_basic.json'),
  circularLoadingDark(path: 'assets/lottie/circular_loading_dark.json'),
  refreshDraggingBasic(path: 'assets/lottie/refresh_dragging_basic.json'),
  refreshDraggingDark(path: 'assets/lottie/refresh_dragging_dark.json'),
  refreshLoadingBasic(path: 'assets/lottie/refresh_loading_basic.json'),
  refreshLoadingDark(path: 'assets/lottie/refresh_loading_dark.json');

  const GdsLottie({required this.path});

  final String path;

  @override
  Widget build({double? width, double? height}) {
    final lottieWidth = width ?? GdsAtomicIconSize.v24;
    final lottieHeight = height ?? GdsAtomicIconSize.v24;

    return Lottie.asset(
      path,
      package: 'gds_foundation',
      width: lottieWidth,
      height: lottieHeight,
      fit: BoxFit.contain,
    );
  }
}
