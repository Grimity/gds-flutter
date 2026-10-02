import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsListItem.section]에 대한 프리뷰 위젯.
class GdsListItemSectionPreview extends PreviewWidget {
  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  @override
  String get displayName => 'Section';

  @override
  List<String> get groups => ['Cell', 'List Item'];

  @override
  Widget build(BuildContext context) {
    return GdsListItem.section(label: labelControl.of(context).value);
  }
}
