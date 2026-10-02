import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsDmListItem]에 대한 프리뷰 위젯.
class GdsDmListItemPreview extends PreviewWidget {
  final activeControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Active',
  );

  final checkedControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Checked',
  );

  final checkableControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Checkable',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final messageControl = PreviewControl.string(
    defaultValue: '안녕하세요!',
    displayName: 'Message',
  );

  final hoursAgoControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Hours Ago',
    minValue: 0,
  );

  final unreadCountControl = PreviewControl.integer(
    defaultValue: 3,
    displayName: 'Unread Count',
    minValue: 0,
  );

  @override
  String get displayName => 'DM List Item';

  @override
  List<String> get groups => ['DM'];

  @override
  Widget build(BuildContext context) {
    final active = activeControl.of(context);
    final checked = checkedControl.of(context);
    final checkable = checkableControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final nickname = nicknameControl.of(context);
    final message = messageControl.of(context);
    final hoursAgo = hoursAgoControl.of(context);
    final unreadCount = unreadCountControl.of(context);

    return GdsDmListItem(
      active: active.value,
      checked: checked.value,
      checkable: checkable.value,
      profileUrl: profileUrl.mayBeValue,
      nickname: nickname.value,
      message: message.value,
      createdAt: DateTime.now().subtract(Duration(hours: hoursAgo.value)),
      unreadCount: unreadCount.value,
      onTap: () => debugPrint('onTap() called'),
      onChanged: (value) => checked.value = value,
    );
  }
}
