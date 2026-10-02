import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsNavigation]에 대한 프리뷰 위젯.
class GdsNavigationPreview extends PreviewWidget {
  final indexControl = PreviewControl.integer(
    defaultValue: 0,
    displayName: 'Index',
    minValue: 0,
    maxValue: 99,
  );

  final pageCountControl = PreviewControl.integer(
    defaultValue: 10,
    displayName: 'Page Count',
    minValue: 1,
    maxValue: 99,
  );

  final maxCountControl = PreviewControl.integer(
    defaultValue: 5,
    displayName: 'Max Count',
    minValue: 1,
    maxValue: 10,
  );

  @override
  String get displayName => 'Navigation';

  @override
  List<String> get groups => ['Pagination'];

  @override
  Widget build(BuildContext context) {
    final index = indexControl.of(context);
    final pageCount = pageCountControl.of(context);
    final maxCount = maxCountControl.of(context);
    final currentIndex = index.value.clamp(0, pageCount.value - 1).toInt();

    return GdsNavigation(
      index: currentIndex,
      pageCount: pageCount.value,
      maxCount: maxCount.value,
      onChanged: (newIndex) => index.value = newIndex,
    );
  }
}
