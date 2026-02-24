import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

part 'user_info/gds_default_user_info.dart';

part 'user_info/gds_community_user_info.dart';

part 'user_info/gds_comment_user_info.dart';

part 'user_info/gds_follow_user_info.dart';

enum GdsUserInfoType {
  defaultType,
  community,
  comment,
  follow,
}

class GdsUserInfo extends StatelessWidget {
  final GdsUserInfoType type;

  final String nickName;
  final VoidCallback? onNameTap;
  final bool showChat;
  final int? chatCount;
  final bool showHeart;
  final int? heartCount;
  final bool showView;
  final int? viewCount;
  final bool showTime;
  final String? timeText;
  final bool showTag;
  final int followerCount;
  final VoidCallback? onFollowerTap;
  final bool showFollowing;
  final int? followingCount;
  final VoidCallback? onFollowingTap;

  const GdsUserInfo.defaultType({
    super.key,
    required this.nickName,
    this.onNameTap,
    this.showHeart = true,
    this.heartCount,
    this.showView = true,
    this.viewCount,
    this.showTime = true,
    this.timeText,
  }) : type = GdsUserInfoType.defaultType,
       showChat = false,
       chatCount = null,
       showTag = false,
       followerCount = 0,
       onFollowerTap = null,
       showFollowing = false,
       followingCount = null,
       onFollowingTap = null;

  const GdsUserInfo.community({
    super.key,
    this.showChat = true,
    this.chatCount,
    this.showHeart = true,
    this.heartCount,
    this.showView = true,
    this.viewCount,
    this.showTime = true,
    this.timeText,
  }) : type = GdsUserInfoType.community,
       nickName = '',
       onNameTap = null,
       showTag = false,
       followerCount = 0,
       onFollowerTap = null,
       showFollowing = false,
       followingCount = null,
       onFollowingTap = null;

  const GdsUserInfo.comment({
    super.key,
    required this.nickName,
    this.onNameTap,
    this.showTag = true,
    this.showTime = true,
    this.timeText,
  }) : type = GdsUserInfoType.comment,
       showChat = false,
       chatCount = null,
       showHeart = false,
       heartCount = null,
       showView = false,
       viewCount = null,
       followerCount = 0,
       onFollowerTap = null,
       showFollowing = false,
       followingCount = null,
       onFollowingTap = null;

  const GdsUserInfo.follow({
    super.key,
    required this.followerCount,
    this.onFollowerTap,
    this.showFollowing = true,
    this.followingCount,
    this.onFollowingTap,
  }) : type = GdsUserInfoType.follow,
       nickName = '',
       onNameTap = null,
       showChat = false,
       chatCount = null,
       showHeart = false,
       heartCount = null,
       showView = false,
       viewCount = null,
       showTime = false,
       timeText = null,
       showTag = false;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      GdsUserInfoType.defaultType => GdsDefaultUserInfo(
        nickName: nickName,
        onNameTap: onNameTap,
        showHeart: showHeart,
        heartCount: heartCount,
        showView: showView,
        viewCount: viewCount,
        showTime: showTime,
        timeText: timeText,
      ),
      GdsUserInfoType.community => GdsCommunityUserInfo(
        showChat: showChat,
        chatCount: chatCount,
        showHeart: showHeart,
        heartCount: heartCount,
        showView: showView,
        viewCount: viewCount,
        showTime: showTime,
        timeText: timeText,
      ),
      GdsUserInfoType.comment => GdsCommentUserInfo(
        nickName: nickName,
        onNameTap: onNameTap,
        showTag: showTag,
        showTime: showTime,
        timeText: timeText,
      ),
      GdsUserInfoType.follow => GdsFollowUserInfo(
        followerCount: followerCount,
        onFollowerTap: onFollowerTap,
        showFollowing: showFollowing,
        followingCount: followingCount,
        onFollowingTap: onFollowingTap,
      ),
    };
  }
}

class DotSeparator extends StatelessWidget {
  const DotSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final dotColor = context.gdsColors.surface.graySubtle;

    return Row(
      children: [
        const SizedBox(width: GdsSpacing.spacing4),
        Container(
          width: GdsSpacing.spacing2,
          height: GdsSpacing.spacing2,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: GdsSpacing.spacing4),
      ],
    );
  }
}
