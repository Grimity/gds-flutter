import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTopNavigation.iconButton]에 대한 프리뷰 위젯.
class GdsIconButtonTopNavigationPreview extends PreviewWidget {
  final titleControl = PreviewControl.string(
    initialValue: 'Title',
    displayName: 'Title',
  );

  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  final buttonCountControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Button Count',
    minValue: 0,
    maxValue: 3,
  );

  @override
  String get displayName => 'Icon Button';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final icon = iconControl.of(context);
    final buttonCount = buttonCountControl.of(context);

    final actions = List.generate(buttonCount.value, (index) {
      return GdsIconButtonAction(
        icon: icon.value,
        onTap: () => debugPrint('Icon button ${index + 1} onTap() called'),
      );
    });

    return GdsTopNavigation.iconButton(
      onBack: () => debugPrint('onBack() called'),
      actions: actions,
      title: title.mayBeValue,
    );
  }
}
