import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsPushBadge.dot]에 대한 프리뷰 위젯.
class GdsDotPushBadgePreview extends PreviewWidget {
  final positionControl = PreviewControl.select<GdsDotPushBadgePosition>(
    defaultValue: .topRight,
    displayName: 'Position',
    values: GdsDotPushBadgePosition.values,
  );

  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .sm,
    displayName: 'Size',
    values: const [.xs, .sm, .md],
  );

  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .blank,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  @override
  String get displayName => 'Push Badge · Dot';

  @override
  List<String> get groups => ['Base'];

  @override
  Widget build(BuildContext context) {
    final position = positionControl.of(context);
    final size = sizeControl.of(context);
    final icon = iconControl.of(context);

    return GdsPushBadge.dot(
      position: position.value,
      size: size.value,
      child: icon.value.build(size: 32, color: .iconGrayBold),
    );
  }
}
