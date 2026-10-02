import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTab]에 대한 프리뷰 위젯.
class GdsTabViewPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: [.lg, .md, .sm],
  );

  @override
  String get displayName => 'Tab';

  @override
  List<String> get groups => ['Tab'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);

    // 고정 탭 목록.
    const items = <GdsTabItem>[
      .new(label: 'Posts', count: 12),
      .new(label: 'Likes', count: 4),
      .new(label: 'About'),
    ];

    return IntrinsicHeight(
      child: GdsTab(
        size: size.value,
        items: items,
        pages: [],
      ),
    );
  }
}
