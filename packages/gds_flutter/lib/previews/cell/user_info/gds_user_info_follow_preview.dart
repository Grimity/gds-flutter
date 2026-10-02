import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/components/cell/gds_user_info.dart';

/// [GdsUserInfo.follow] preview widget.
class GdsUserInfoFollowPreview extends PreviewWidget {
  final followerCountControl = PreviewControl.integer(
    defaultValue: 1234,
    displayName: 'Follower Count',
    minValue: 0,
  );

  final followingCountControl = PreviewControl.integer(
    defaultValue: 567,
    displayName: 'Following Count',
    minValue: 0,
  );

  @override
  String get displayName => 'Follow';

  @override
  List<String> get groups => ['Cell', 'User Info'];

  @override
  Widget build(BuildContext context) {
    return GdsUserInfo.follow(
      followerCount: followerCountControl.of(context).value,
      followingCount: followingCountControl.of(context).value,
    );
  }
}
