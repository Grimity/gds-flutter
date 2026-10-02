import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsCounter]에 대한 프리뷰 위젯.
class GdsCounterPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.lg, .md],
  );

  final countControl = PreviewControl.integer(
    defaultValue: 3,
    displayName: 'Count',
    minValue: 1,
    maxValue: 99,
  );

  final maxCountControl = PreviewControl.integer(
    defaultValue: 10,
    displayName: 'Max Count',
    minValue: 1,
    maxValue: 99,
  );

  @override
  String get displayName => 'Counter';

  @override
  List<String> get groups => ['Pagination'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final count = countControl.of(context);
    final maxCount = maxCountControl.of(context);

    return GdsCounter(
      size: size.value,
      count: count.value,
      maxCount: maxCount.value,
    );
  }
}
