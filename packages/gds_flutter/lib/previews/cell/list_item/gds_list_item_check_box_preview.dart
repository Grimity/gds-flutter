import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListItem.checkBox]에 대한 프리뷰 위젯.
class GdsListItemCheckBoxPreview extends PreviewWidget {
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
  String get displayName => 'Check Box';

  @override
  List<String> get groups => ['Cell', 'List Item'];

  @override
  Widget build(BuildContext context) {
    final label = labelControl.of(context);
    final status = statusControl.of(context);

    return GdsListItem.checkBox(
      onTap: () => debugPrint('onTap() called'),
      label: label.value,
      status: status.value,
    );
  }
}
