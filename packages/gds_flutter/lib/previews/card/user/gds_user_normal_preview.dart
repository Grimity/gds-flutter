import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUser.normal]에 대한 프리뷰 위젯.
class GdsUserNormalPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

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

  final followingControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Following',
  );

  @override
  String get displayName => 'Normal';

  @override
  List<String> get groups => ['Card', 'User'];

  @override
  Widget build(BuildContext context) {
    final showSkeleton = showSkeletonControl.of(context);
    final nickname = nicknameControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final followerCount = followerCountControl.of(context);
    final followingCount = followingCountControl.of(context);
    final following = followingControl.of(context);

    return GdsSkeleton(
      enabled: showSkeleton.value,
      child: GdsUser.normal(
        nickname: nickname.value,
        profile: profileUrl.mayBeValue?.networkImage,
        followerCount: followerCount.value,
        followingCount: followingCount.value,
        thumbnails: [],
        following: following.value,
        onTap: () => debugPrint('onTap() called'),
        onFollow: () => debugPrint('onFollow() called'),
        onUnFollow: () => debugPrint('onUnFollow() called'),
      ),
    );
  }
}
