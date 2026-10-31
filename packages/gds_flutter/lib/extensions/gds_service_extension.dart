// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 디자인 시스템에서 제공하는 [Service]에 대한 유틸리티 확장.
extension GdsServiceExtension<T> on Service<T> {
  /// 데이터가 없으면 [placeholder]로 빌드하며, 로딩 중에는 스켈레톤을,
  /// 새로고침 중에는 입력을 차단하고, 실패 시에는 오류 상태를 표시합니다.
  Widget builder({
    Key? key,
    required T placeholder,
    required Widget Function(T data) builder,
  }) {
    return GdsTransition.crossFade(
      value: (this, isLoading, hasError),
      child: Builder(
        builder: (context) {
          if (hasError) {
            return GdsErrorState(
              retry: refresh,
              error: error,
              stackTrace: stackTrace,
            );
          }

          return GdsSkeleton(
            enabled: isLoading,
            child: builder(maybeData ?? placeholder),
          );
        },
      ),
    );
  }

  /// 데이터가 없으면 [placeholder]로 빌드하며, 로딩 중에는 스켈레톤을,
  /// 새로고침 중에는 입력을 차단하고, 실패 시에는 오류 상태를 표시합니다.
  Widget sliver({
    Key? key,
    required T placeholder,
    required Widget Function(T data) builder,
  }) {
    return GdsSliverTransition.crossFade(
      value: (this, isLoading, hasError),
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

          return GdsSliverSkeleton(
            enabled: isLoading,
            child: builder(maybeData ?? placeholder),
          );
        },
      ),
    );
  }

  /// 주로 페이지 로드에 사용하며, 로딩 중에는 인디케이터를,
  /// 실패 시에는 오류 상태를, 완료 시에는 본문을 표시합니다.
  Widget page({
    Widget? Function(Object error, StackTrace stackTrace)? failed,
    required Widget Function(T data) loaded,
  }) {
    return when(
      failed: (error, stackTrace) {
        final child = failed?.call(error, stackTrace);
        if (child != null) {
          return child;
        }

        return GdsErrorState(
          retry: refresh,
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () {
        return const Center(
          child: GdsCircularLoading(),
        );
      },
      loaded: loaded,
    );
  }
}
