import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsMenu]에 대한 프리뷰 위젯.
class GdsMenuPreview extends PreviewWidget {
  final labelControl = PreviewControl.string(
    defaultValue: '메뉴',
    displayName: 'Label',
  );

  final itemCountControl = PreviewControl.integer(
    defaultValue: 3,
    displayName: 'Items per Group',
    minValue: 1,
    maxValue: 8,
  );

  final groupCountControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Group Count',
    minValue: 1,
    maxValue: 3,
  );

  @override
  String get displayName => 'Menu';

  @override
  List<String> get groups => ['GNB'];

  @override
  Widget build(BuildContext context) {
    final label = labelControl.of(context);
    final itemCount = itemCountControl.of(context);
    final groupCount = groupCountControl.of(context);

    final menuGroups = List.generate(groupCount.value, (groupIndex) {
      return List.generate(itemCount.value, (itemIndex) {
        final index = groupIndex * itemCount.value + itemIndex;

        return (
          label: '${label.value} ${index + 1}',
          onTap: () => debugPrint('GdsMenu.onTap() called with index: $index'),
        );
      });
    });

    return GdsMenu.group(groups: menuGroups);
  }
}
