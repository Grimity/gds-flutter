import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListItem.icon]에 대한 프리뷰 위젯.
class GdsListItemIconPreview extends PreviewWidget {
  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

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
  String get displayName => 'Icon';

  @override
  List<String> get groups => ['Cell', 'List Item'];

  @override
  Widget build(BuildContext context) {
    final icon = iconControl.of(context);
    final label = labelControl.of(context);
    final status = statusControl.of(context);

    return GdsListItem.icon(
      onTap: () => debugPrint('onTap() called'),
      icon: icon.value,
      label: label.value,
      status: status.value,
    );
  }
}
