import 'package:pervice/pervice.dart';

/// 커서에 해당하는 페이지를 요청하는 서비스를 생성하는 빌더.
typedef LoadMoreBuilder<T> = Service<T> Function(String? cursor);

/// 다음 페이지의 커서를 반환하는 함수.
typedef LoadMoreCursorOf<T> = String? Function(T data);

/// 커서를 기반으로 다음 페이지를 불러오고 이를 관리하는 서비스.
class LoadMoreService<T> extends Service<List<T>> {
  new({
    required this.builder,
    required this.cursorOf,
  });

  final LoadMoreBuilder<T> builder;
  final LoadMoreCursorOf<T> cursorOf;

  /// 추가 로딩이 가능한지, 즉 마지막 페이지에 다음 커서가 있는지 여부를 반환합니다.
  bool get canLoreMore {
    return status == .loaded ? cursorOf(data.last) != null : false;
  }

  /// 기존 콘텐츠를 유지하면서 다음 페이지를 불러오고 이를 삽입합니다.
  Future<void> loadMore() async {
    data.add(await builder(cursorOf(data.last)).request());
    notifyUpdated();
  }

  @override
  Future<List<T>> fetchData() async {
    return [await builder(null).request()];
  }
}
