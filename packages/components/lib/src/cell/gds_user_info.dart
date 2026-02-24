import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

part 'user_info/gds_default_user_info.dart';

part 'user_info/gds_community_user_info.dart';

part 'user_info/gds_comment_user_info.dart';

part 'user_info/gds_follow_user_info.dart';

abstract class GdsUserInfo extends StatelessWidget {
  const GdsUserInfo({super.key});

  const factory GdsUserInfo.defaultType({
    Key? key,
    required String nickName,
    VoidCallback? onNameTap,
    required bool showHeart,
    int? heartCount,
    required bool showView,
    int? viewCount,
    required bool showTime,
    String? timeText,
  }) = GdsDefaultUserInfo;

  const factory GdsUserInfo.community({
    Key? key,
    required bool showChat,
    int? chatCount,
    required bool showHeart,
    int? heartCount,
    required bool showView,
    int? viewCount,
    required bool showTime,
    String? timeText,
  }) = GdsCommunityUserInfo;

  const factory GdsUserInfo.comment({
    Key? key,
    required String nickName,
    VoidCallback? onNameTap,
    required bool showTag,
    required bool showTime,
    String? timeText,
  }) = GdsCommentUserInfo;

  const factory GdsUserInfo.follow({
    Key? key,
    required int followerCount,
    VoidCallback? onFollowerTap,
    required bool showFollowing,
    int? followingCount,
    VoidCallback? onFollowingTap,
  }) = GdsFollowUserInfo;
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
