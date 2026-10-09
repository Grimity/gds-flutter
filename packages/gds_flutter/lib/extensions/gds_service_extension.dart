import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 디자인 시스템에서 제공하는 [Service]에 대한 유틸리티 확장.
extension GdsServiceExtension<T> on Service<T> {
  static const _animation = GdsAnimation.normal;

  /// 데이터가 없으면 [placeholder]로 빌드하며, 로딩 중에는 스켈레톤을,
  /// 새로고침 중에는 반투명 콘텐츠를 표시합니다.
  Widget builder({
    Key? key,
    required T placeholder,
    required Widget Function(T data) builder,
  }) {
    return build(child: builder(maybeData ?? placeholder));
  }

  /// 로딩 중에는 스켈레톤을 표시하고, 새로고침 중에는 콘텐츠를 반투명하게 표시합니다.
  Widget build({
    Key? key,
    required Widget child,
  }) {
    return AnimatedOpacity(
      opacity: isRefreshing ? 0.5 : 1.0,
      duration: _animation.duration,
      curve: _animation.curve,
      child: GdsSkeleton(enabled: isLoading, child: child),
    );
  }
}
