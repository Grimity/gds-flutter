import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsBottomNavigation]에 대한 프리뷰 위젯.
class GdsBottomNavigationPreview extends PreviewWidget {
  final indexControl = PreviewControl.integer(
    defaultValue: 0,
    displayName: 'Index',
    minValue: 0,
    maxValue: 4,
  );

  final showDotControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Dot',
  );

  @override
  String get displayName => 'Tabs';

  @override
  List<String> get groups => ['Navigation', 'Bottom Navigation'];

  @override
  Widget build(BuildContext context) {
    final index = indexControl.of(context);
    final showDot = showDotControl.of(context);

    void onTap(int newIndex) {
      debugPrint('GdsBottomNavigationItem.onTap() called with index: $newIndex');
      index.value = newIndex;
    }

    return GdsBottomNavigation(
      index: index.value,
      tabs: [
        .new(icon: .home, label: '홈', onTap: () => onTap(0)),
        .new(icon: .paint, label: '랭킹', onTap: () => onTap(1)),
        .new(icon: .following, label: '팔로잉', onTap: () => onTap(2)),
        .new(icon: .board, label: '자유게시판', onTap: () => onTap(3)),
        .new(icon: .message, label: 'DM', showDot: showDot.value, onTap: () => onTap(4)),
      ],
    );
  }
}
