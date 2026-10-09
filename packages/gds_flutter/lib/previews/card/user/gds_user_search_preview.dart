import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsUser.search]에 대한 프리뷰 위젯.
class GdsUserSearchPreview extends PreviewWidget {
  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final introductionControl = PreviewControl.string(
    defaultValue: '소개글은 여기에 표시되며 최대 2줄입니다.',
    displayName: 'Introduction',
  );

  final profileUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Profile URL',
  );

  final bannerUrlControl = PreviewControl.string(
    initialValue: previewProfileUrl,
    displayName: 'Banner URL',
  );

  final followerCountControl = PreviewControl.integer(
    defaultValue: 1234,
    displayName: 'Follower Count',
    minValue: 0,
  );

  final followingControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Following',
  );

  @override
  String get displayName => 'Search';

  @override
  List<String> get groups => ['Card', 'User'];

  @override
  Widget build(BuildContext context) {
    final showSkeleton = showSkeletonControl.of(context);
    final nickname = nicknameControl.of(context);
    final introduction = introductionControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final bannerUrl = bannerUrlControl.of(context);
    final followerCount = followerCountControl.of(context);
    final following = followingControl.of(context);

    return GdsSkeleton(
      enabled: showSkeleton.value,
      child: GdsUser.search(
        nickname: nickname.value,
        introduction: introduction.value,
        followerCount: followerCount.value,
        profile: profileUrl.mayBeValue?.networkImage,
        banner: bannerUrl.mayBeValue?.networkImage,
        following: following.value,
        onTap: () => debugPrint('onTap() called'),
        onFollow: () => debugPrint('onFollow() called'),
        onUnFollow: () => debugPrint('onUnFollow() called'),
      ),
    );
  }
}
