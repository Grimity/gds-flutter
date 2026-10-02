import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListItem.text]에 대한 프리뷰 위젯.
class GdsListItemTextPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .lg,
    displayName: 'Size',
    values: [.lg, .md],
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final statusControl = PreviewControl.select<GdsCellStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: GdsCellStatus.values,
  );

  @override
  String get displayName => 'Text';

  @override
  List<String> get groups => ['Cell', 'List Item'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final label = labelControl.of(context);
    final status = statusControl.of(context);

    return GdsListItem.text(
      onTap: () => debugPrint('onTap() called'),
      size: size.value,
      label: label.value,
      status: status.value,
    );
  }
}
