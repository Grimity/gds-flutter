// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:pervice/pervice.dart';

/// 커서에 해당하는 페이지를 요청하는 서비스를 생성하는 빌더.
typedef LoadMoreBuilder<T> = Service<T> Function(String? cursor);

/// 다음 페이지의 커서를 반환하는 함수.
typedef LoadMoreCursorOf<T> = String? Function(T data);

/// 커서를 기반으로 다음 페이지를 불러오고 이를 관리하는 서비스.
class LoadMoreService<T> extends Service<List<T>> {
  new({
    required this._builder,
    required this._cursorOf,
  });

  final LoadMoreBuilder<T> _builder;
  final LoadMoreCursorOf<T> _cursorOf;

  /// 추가 페이지 요청이 진행 중인지 여부.
  bool isLoadingMore = false;

  /// 추가 로딩이 가능한지, 즉 마지막 페이지에 다음 커서가 있는지 여부를 반환합니다.
  bool get canLoreMore {
    return status == .loaded && !isLoadingMore ? _cursorOf(data.last) != null : false;
  }

  /// 기존 콘텐츠를 유지하면서 다음 페이지를 불러오고 이를 삽입합니다.
  /// 또한 이미 추가 로딩 중이면 해당 함수를 호출하지 않아야 합니다.
  Future<void> loadMore() async {
    if (isLoadingMore) {
      throw StateError('이미 추가 페이지를 불러오는 중입니다.');
    }

    try {
      isLoadingMore = true;
      data.add(await _builder(_cursorOf(data.last)).request());
      notifyChanged();
    } finally {
      isLoadingMore = false;
    }
  }

  @override
  Future<List<T>> fetchData() async {
    return [await _builder(null).request()];
  }
}
