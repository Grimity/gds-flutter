import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/components/cell/gds_user_info.dart';

/// [GdsUserInfo.normal] preview widget.
class GdsUserInfoNormalPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    initialValue: 'Nickname',
    displayName: 'Nickname',
  );

  final commentCountControl = PreviewControl.integer(
    initialValue: 12,
    displayName: 'Comment Count',
    minValue: 0,
  );

  final likeCountControl = PreviewControl.integer(
    initialValue: 34,
    displayName: 'Like Count',
    minValue: 0,
  );

  final viewCountControl = PreviewControl.integer(
    initialValue: 567,
    displayName: 'View Count',
    minValue: 0,
  );

  final hoursAgoControl = PreviewControl.integer(
    defaultValue: 1,
    displayName: 'Hours Ago',
    minValue: 0,
  );

  @override
  String get displayName => 'Normal';

  @override
  List<String> get groups => ['Cell', 'User Info'];

  @override
  Widget build(BuildContext context) {
    final nickname = nicknameControl.of(context);
    final commentCount = commentCountControl.of(context);
    final likeCount = likeCountControl.of(context);
    final viewCount = viewCountControl.of(context);
    final hoursAgo = hoursAgoControl.of(context);

    return GdsUserInfo.normal(
      nickname: nickname.mayBeValue,
      commentCount: commentCount.mayBeValue,
      likeCount: likeCount.mayBeValue,
      viewCount: viewCount.mayBeValue,
      date: DateTime.now().subtract(Duration(hours: hoursAgo.value)),
    );
  }
}
