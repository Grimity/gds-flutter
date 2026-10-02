import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsUserItem.link]에 대한 프리뷰 위젯.
class GdsUserItemLinkPreview extends PreviewWidget {
  final nameControl = PreviewControl.string(
    defaultValue: 'Web',
    displayName: 'Name',
  );

  final linkControl = PreviewControl.string(
    initialValue: 'https://example.com',
    displayName: 'Link',
  );

  final iconControl = PreviewControl.select<GdsIcon>(
    defaultValue: .link,
    displayName: 'Icon',
    values: GdsIcon.values,
  );

  @override
  String get displayName => 'Link';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final name = nameControl.of(context);
    final link = linkControl.of(context);
    final icon = iconControl.of(context);

    return GdsUserItem.link(
      name: name.value,
      link: link.mayBeValue,
      icon: icon.value,
    );
  }
}
