import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsRefreshLoading]에 대한 프리뷰 위젯.
class GdsRefreshLoadingPreview extends PreviewWidget {
  final sizeControl = PreviewControl.double(
    defaultValue: 24,
    displayName: 'Size',
    minValue: 12,
    maxValue: 32,
  );

  @override
  String get displayName => 'Refresh Loading';

  @override
  List<String> get groups => ['Base'];

  @override
  Widget build(BuildContext context) {
    return GdsRefreshLoading(size: sizeControl.of(context).value);
  }
}
