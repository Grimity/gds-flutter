import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsGroup]에 대한 프리뷰 위젯.
class GdsGroupPreview extends PreviewWidget {
  final statusControl = PreviewControl.select<GdsGroupStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: GdsGroupStatus.values,
  );

  @override
  String get displayName => 'Group';

  @override
  List<String> get groups => ['Group'];

  @override
  Widget build(BuildContext context) {
    final status = statusControl.of(context);

    return GdsGroup(status: status.value);
  }
}
