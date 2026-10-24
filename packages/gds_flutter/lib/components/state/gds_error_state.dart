import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 오류가 발생했을 때 안내 문구와 다시 시도 버튼을 표시하는 위젯.
@GdsSupportedSizes([.xl, .md])
class GdsErrorState extends StatelessWidget {
  const new({
    super.key,
    this.size,
    required this.retry,
    required this.error,
    required this.stackTrace,
  });

  final GdsSize? size;
  final AsyncCallback retry;
  final Object error;
  final StackTrace stackTrace;

  /// 발생한 오류와 스택 트레이스를 외부에 보고하기 위한 콜백.
  static void Function(Object, StackTrace)? onReport;

  @override
  Widget build(BuildContext context) {
    final loading = context.stateOf(() => false);

    // 초기 빌드에서 등록된 콜백에 주어진 오류와 스택 트레이스를 전달.
    context.onInitState(() {
      onReport?.call(error, stackTrace);
    });

    return GdsEmptyState(
      size: size,
      illust: .warning,
      title: '알 수 없는 에러가 발생했어요',
      description: error.toString(),
      action: .new(
        type: .solid,
        label: '다시 시도',
        onTap: () => loading.run(retry),
      ),
    );
  }
}
