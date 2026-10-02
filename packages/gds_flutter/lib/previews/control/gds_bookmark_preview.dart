import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/components/control/gds_bookmark.dart';

/// [GdsBookmark]에 대한 프리뷰 위젯.
class GdsBookmarkPreview extends PreviewWidget {
  final valueControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Value',
  );

  final blackControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Black',
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  @override
  String get displayName => 'Bookmark';

  @override
  List<String> get groups => ['Control'];

  @override
  Widget build(BuildContext context) {
    final value = valueControl.of(context);
    return GdsBookmark(
      value: value.value,
      black: blackControl.of(context).value,
      enabled: enabledControl.of(context).value,
      onChanged: (newValue) => value.value = newValue,
    );
  }
}
