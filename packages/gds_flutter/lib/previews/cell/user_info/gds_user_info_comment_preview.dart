import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/components/cell/gds_user_info.dart';

/// [GdsUserInfo.comment] preview widget.
class GdsUserInfoCommentPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final isWriterControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Is Writer',
  );

  final hoursAgoControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Hours Ago',
    minValue: 0,
  );

  @override
  String get displayName => 'Comment';

  @override
  List<String> get groups => ['Cell', 'User Info'];

  @override
  Widget build(BuildContext context) {
    return GdsUserInfo.comment(
      nickname: nicknameControl.of(context).value,
      isWriter: isWriterControl.of(context).value,
      date: DateTime.now().subtract(
        Duration(hours: hoursAgoControl.of(context).value),
      ),
    );
  }
}
