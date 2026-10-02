import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsCircularLoading]에 대한 프리뷰 위젯.
class GdsCircularLoadingPreview extends PreviewWidget {
  final sizeControl = PreviewControl.double(
    defaultValue: 24,
    displayName: 'Size',
    minValue: 12,
    maxValue: 32,
  );

  @override
  String get displayName => 'Circular Loading';

  @override
  List<String> get groups => ['Base'];

  @override
  Widget build(BuildContext context) {
    return GdsCircularLoading(size: sizeControl.of(context).value);
  }
}
