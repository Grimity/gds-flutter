import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListItem.rightIcon]에 대한 프리뷰 위젯.
class GdsListItemRightIconPreview extends PreviewWidget {
  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final iconLabelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Icon Label',
  );

  final statusControl = PreviewControl.select<GdsCellStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: [.enabled, .selected, .disabled],
  );

  @override
  String get displayName => 'Right Icon';

  @override
  List<String> get groups => ['Cell', 'List Item'];

  @override
  Widget build(BuildContext context) {
    final icon = iconControl.of(context);
    final label = labelControl.of(context);
    final iconLabel = iconLabelControl.of(context);
    final status = statusControl.of(context);

    return GdsListItem.rightIcon(
      onTap: () => debugPrint('onTap() called'),
      icon: icon.value,
      label: label.value,
      iconLabel: iconLabel.value,
      status: status.value,
    );
  }
}
