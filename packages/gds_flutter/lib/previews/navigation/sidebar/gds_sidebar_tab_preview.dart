import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsSidebarTab]에 대한 프리뷰 위젯.
class GdsSidebarTabPreview extends PreviewWidget {
  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final showDotControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Show Dot',
  );

  @override
  String get displayName => 'Tab';

  @override
  List<String> get groups => ['Navigation', 'Sidebar'];

  @override
  Widget build(BuildContext context) {
    final icon = iconControl.of(context);
    final label = labelControl.of(context);
    final showDot = showDotControl.of(context);

    return GdsSidebarTab(
      icon: icon.value,
      label: label.value,
      showDot: showDot.value,
      onTap: () => debugPrint('onTap() called'),
    );
  }
}
