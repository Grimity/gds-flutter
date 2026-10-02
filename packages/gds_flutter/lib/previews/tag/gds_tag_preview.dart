import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTag]에 대한 프리뷰 위젯.
class GdsTagPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.md, .xs],
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  final iconControl = PreviewControl.select<GdsIcon>(
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  @override
  String get displayName => 'Tag';

  @override
  List<String> get groups => ['Tag'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final label = labelControl.of(context);
    final enabled = enabledControl.of(context);
    final icon = iconControl.of(context);

    return GdsTag(
      size: size.value,
      label: label.value,
      enabled: enabled.value,
      icon: icon.mayBeValue,
      onTap: () => debugPrint('onTap() called'),
    );
  }
}
