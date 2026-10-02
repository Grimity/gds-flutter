import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListItem.checkMark]에 대한 프리뷰 위젯.
class GdsListItemCheckMarkPreview extends PreviewWidget {
  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final statusControl = PreviewControl.select<GdsCellStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: [.enabled, .selected, .disabled],
  );

  @override
  String get displayName => 'Check Mark';

  @override
  List<String> get groups => ['Cell', 'List Item'];

  @override
  Widget build(BuildContext context) {
    final label = labelControl.of(context);
    final status = statusControl.of(context);

    return GdsListItem.checkMark(
      onTap: () => debugPrint('onTap() called'),
      label: label.value,
      status: status.value,
    );
  }
}
