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
      loadingIndicator: const GdsCircularLoading(),
      preloadOffset: 500,
      onLoadMore: onLoadMore,
      isEnabled: enabled,
      reverse: reverse,
      child: child,
    );
  }
}
