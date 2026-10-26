import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/common/gds_disabled.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 디자인 시스템에서 제공하는 [Service]에 대한 유틸리티 확장.
extension GdsServiceExtension<T> on Service<T> {
  /// 데이터가 없으면 [placeholder]로 빌드하며, 로딩 중에는 스켈레톤을,
  /// 새로고침 중에는 반투명 콘텐츠를, 실패 시에는 오류 상태를 표시합니다.
  Widget builder({
    Key? key,
    required T placeholder,
    required Widget Function(T data) builder,
  }) {
    return GdsTransition.crossFade(
      value: hasError,
      child: Builder(
        builder: (context) {
          if (hasError) {
            return GdsErrorState(
              retry: refresh,
              error: error,
              stackTrace: stackTrace,
            );
          }

          return GdsDisabled(
            enabled: !isRefreshing,
            child: GdsSkeleton(
              enabled: isLoading,
              child: builder(maybeData ?? placeholder),
            ),
          );
        },
      ),
    );
  }

  /// 데이터가 없으면 [placeholder]로 빌드하며, 로딩 중에는 스켈레톤을,
  /// 새로고침 중에는 반투명 콘텐츠를, 실패 시에는 오류 상태를 표시합니다.
  Widget sliver({
    Key? key,
    required T placeholder,
    required Widget Function(T data) builder,
  }) {
    return GdsSliverTransition.crossFade(
      value: hasError,
      child: Builder(
        builder: (context) {
          if (hasError) {
            return SliverToBoxAdapter(
              child: GdsErrorState(
                retry: refresh,
                error: error,
                stackTrace: stackTrace,
              ),
            );
          }

          return GdsSliverDisabled(
            enabled: !isRefreshing,
            sliver: GdsSliverSkeleton(
              enabled: isLoading,
              child: builder(maybeData ?? placeholder),
            ),
          );
        },
      ),
    );
  }
}
