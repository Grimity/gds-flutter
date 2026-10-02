import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsButton.icon]에 대한 프리뷰 위젯.
class GdsIconButtonPreview extends PreviewWidget {
  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  final typeControl = PreviewControl.select<GdsIconButtonType>(
    defaultValue: .normal,
    displayName: 'Type',
    values: GdsIconButtonType.values,
  );

  final statusControl = PreviewControl.select<GdsButtonStatus>(
    defaultValue: .enabled,
    displayName: 'Status',
    values: GdsButtonStatus.values,
  );

  @override
  String get displayName => 'Icon';

  @override
  List<String> get groups => ['Button'];

  @override
  Widget build(BuildContext context) {
    final icon = iconControl.of(context);
    final type = typeControl.of(context);
    final status = statusControl.of(context);

    return GdsButton.icon(
      onTap: () => debugPrint('onTap() called'),
      icon: icon.value,
      type: type.value,
      status: status.value,
    );
  }
}
