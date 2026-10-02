import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsTopNavigation.title]에 대한 프리뷰 위젯.
class GdsTitleTopNavigationPreview extends PreviewWidget {
  final titleControl = PreviewControl.string(
    initialValue: 'Title',
    displayName: 'Title',
  );

  final hasNotificationControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Has Notification',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  @override
  String get displayName => 'Title';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final title = titleControl.of(context);
    final hasNotification = hasNotificationControl.of(context);
    final profileUrl = profileUrlControl.of(context);

    return GdsTopNavigation.title(
      onBack: () => debugPrint('onBack() called'),
      onSearch: () => debugPrint('onSearch() called'),
      onNotification: () => debugPrint('onNotification() called'),
      onProfile: () => debugPrint('onProfile() called'),
      title: title.mayBeValue,
      profileUrl: profileUrl.mayBeValue,
      hasNotification: hasNotification.value,
    );
  }
}
