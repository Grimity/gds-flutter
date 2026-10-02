import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsUserItem.notification]에 대한 프리뷰 위젯.
class GdsUserItemNotificationPreview extends PreviewWidget {
  final typeControl = PreviewControl.string(
    defaultValue: '유형',
    displayName: 'Type',
  );

  final contentControl = PreviewControl.string(
    defaultValue: '알림 내용이 여기에 표시됩니다.',
    displayName: 'Content',
  );

  final hoursAgoControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Hours Ago',
    minValue: 0,
  );

  final readControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Read',
  );

  @override
  String get displayName => 'Notification';

  @override
  List<String> get groups => ['Cell', 'User Item'];

  @override
  Widget build(BuildContext context) {
    final type = typeControl.of(context);
    final content = contentControl.of(context);
    final hoursAgo = hoursAgoControl.of(context);
    final read = readControl.of(context);

    return GdsUserItem.notification(
      type: type.value,
      content: content.value,
      createdAt: DateTime.now().subtract(Duration(hours: hoursAgo.value)),
      onClose: () => debugPrint('onClose() called'),
      read: read.value,
    );
  }
}
