import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_pagination/flutter_infinite_scroll_pagination.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템 전반에서 공통으로 사용하는 [InfiniteScrollPagination] 래퍼 위젯.
class GdsInfiniteScroll extends StatelessWidget {
  const new({
    super.key,
    required this.onLoadMore,
    required this.enabled,
    this.reverse = false,
    required this.child,
  });

  final AsyncCallback onLoadMore;
  final bool enabled;
  final bool reverse;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InfiniteScrollPagination(
      loadingIndicator: indicator(),
      preloadOffset: 500,
      onLoadMore: onLoadMore,
      isEnabled: enabled,
      reverse: reverse,
      child: child,
    );
  }

  /// 추가 데이터를 불러오는 동안 표시할 로딩 인디케이터 위젯.
  static Widget indicator({Key? key}) {
    return Padding(
      key: key,
      padding: .all(16),
      child: const GdsCircularLoading(),
    );
  }
}
