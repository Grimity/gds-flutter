import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsCategory]에 대한 프리뷰 위젯.
class GdsCategoryPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.lg, .md],
  );

  final indexControl = PreviewControl.integer(
    defaultValue: 0,
    displayName: 'Index',
    minValue: 0,
    maxValue: 4,
  );

  final showActionControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Action',
  );

  @override
  String get displayName => 'Category';

  @override
  List<String> get groups => ['Category'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final index = indexControl.of(context);
    final showAction = showActionControl.of(context);

    // 액션 버튼.
    final action = GdsIconButtonAction(
      icon: .addSquare,
      onTap: () => debugPrint('GdsCategory.action.onTap() called'),
    );

    return GdsCategory(
      size: size.value,
      index: index.value,
      items: const [
        .new(label: 'All'),
        .new(label: 'Popular', count: 12),
        .new(label: 'Following', count: 8),
        .new(label: 'Artwork', count: 6),
        .new(label: 'Community', count: 4),
      ],
      onChanged: (newIndex) => index.value = newIndex,
      action: showAction.value ? action : null,
    );
  }
}
