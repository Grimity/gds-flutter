import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 페이지 로딩 테스트에 사용할 식별자와 다음 커서 정보.
typedef _Page = ({
  int id,
  String? cursor,
});

/// 테스트에서 지정한 시점에 페이지 응답을 반환하는 서비스.
class _PageService extends Service<_Page> {
  new(this.response);

  final Future<_Page> response;

  @override
  Future<_Page> fetchData() => response;
}

void main() {
  test('다음 커서로 페이지를 추가하고 마지막 페이지에서는 추가 로딩을 종료하는지 확인', () async {
    const first = (id: 1, cursor: 'next');
    const second = (id: 2, cursor: null);

    final cursors = <String?>[];
    final service = LoadMoreService(
      builder: (cursor) {
        cursors.add(cursor);
        return _PageService(.value(cursor == null ? first : second));
      },
      cursorOf: (page) => page.cursor,
    );

    addTearDown(service.dispose);

    // 첫 페이지를 불러오고 추가 로딩 가능 여부 확인.
    await service.load();
    expect(service.canLoreMore, isTrue);

    // 다음 커서로 요청하고 기존 페이지를 유지하는지 확인.
    await service.loadMore();
    expect(cursors, [null, 'next']);
    expect(service.data, [first, second]);
    expect(service.canLoreMore, isFalse);
  });

  test('추가 로딩 중 다시 호출하면 예외가 발생하고 기존 요청만 완료되는지 확인', () async {
    final response = Completer<_Page>();
    var requestCount = 0;

    final service = LoadMoreService(
      builder: (cursor) {
        if (cursor == null) {
          return _PageService(.value((id: 1, cursor: 'next')));
        }

        requestCount++;
        return _PageService(response.future);
      },
      cursorOf: (page) => page.cursor,
    );

    addTearDown(service.dispose);

    // 첫 페이지 이후 다음 페이지를 요청.
    await service.load();
    final first = service.loadMore();

    // 추가 로딩 중 다시 호출하면 예외가 발생하는지 확인.
    await expectLater(service.loadMore(), throwsStateError);

    // 응답을 완료하고 중복 요청과 중복 추가가 없는지 확인.
    response.complete((id: 2, cursor: null));

    await first;
    expect(requestCount, 1);
    expect(service.data.map((page) => page.id), [1, 2]);
  });

  test('새로고침 후 이전 추가 로딩이 완료되어도 새 목록에 섞이지 않는지 확인', () async {
    final response = Completer<_Page>();
    var firstPageCount = 0;
    final service = LoadMoreService(
      builder: (cursor) => _PageService(
        cursor == null ? .value((id: ++firstPageCount, cursor: 'next')) : response.future,
      ),
      cursorOf: (page) => page.cursor,
    );

    addTearDown(service.dispose);

    // 이전 목록의 다음 페이지를 요청한 상태에서 새로고침.
    await service.load();
    final loading = service.loadMore();

    await service.refresh();
    expect(service.data.map((page) => page.id), [2]);

    // 이전 응답이 늦게 도착해도 새 목록이 유지되는지 확인.
    response.complete((id: 3, cursor: null));

    await loading;
    expect(service.data.map((page) => page.id), [2]);
  });
}
