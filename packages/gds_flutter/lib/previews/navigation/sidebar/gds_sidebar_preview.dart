import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/previews/preview.dart';

/// [GdsSidebar]에 대한 프리뷰 위젯.
class GdsSidebarPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .lg,
    displayName: 'Size',
    values: [.lg, .md],
  );

  final nicknameControl = PreviewControl.string(
    defaultValue: 'Nickname',
    displayName: 'Nickname',
  );

  final handleControl = PreviewControl.string(
    defaultValue: 'handle',
    displayName: 'Handle',
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

  final showDotControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Show Dot',
  );

  @override
  String get displayName => 'Sidebar';

  @override
  List<String> get groups => ['Navigation', 'Sidebar'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final nickname = nicknameControl.of(context);
    final handle = handleControl.of(context);
    final profileUrl = profileUrlControl.of(context);
    final followerCount = followerCountControl.of(context);
    final followingCount = followingCountControl.of(context);
    final showDot = showDotControl.of(context);

    return GdsSidebar(
      size: size.value,
      nickname: nickname.value,
      handle: handle.value,
      profileUrl: profileUrl.mayBeValue,
      followerCount: followerCount.value,
      followingCount: followingCount.value,
      onProfile: () => debugPrint('onProfile() called'),
      onNickname: () => debugPrint('onNickname() called'),
      onHandle: () => debugPrint('onHandle() called'),
      onFollower: () => debugPrint('onFollower() called'),
      onFollowing: () => debugPrint('onFollowing() called'),
      onSignOut: () => debugPrint('onSignOut() called'),
      onTermsOfService: () => debugPrint('onTermsOfService() called'),
      onPrivacyPolicy: () => debugPrint('onPrivacyPolicy() called'),
      onBusinessInfo: () => debugPrint('onBusinessInfo() called'),
      tabs: [
        .new(
          icon: .home,
          label: '홈',
          onTap: () => debugPrint('GdsSidebarTab.onTap() called'),
        ),
        .new(
          icon: .paint,
          label: '랭킹',
          onTap: () => debugPrint('GdsSidebarTab.onTap() called'),
        ),
        .new(
          icon: .following,
          label: '팔로잉',
          onTap: () => debugPrint('GdsSidebarTab.onTap() called'),
        ),
        .new(
          icon: .board,
          label: '자유게시판',
          onTap: () => debugPrint('GdsSidebarTab.onTap() called'),
        ),
        .new(
          icon: .message,
          label: 'DM',
          showDot: showDot.value,
          onTap: () => debugPrint('GdsSidebarTab.onTap() called'),
        ),
      ],
    );
  }
}
