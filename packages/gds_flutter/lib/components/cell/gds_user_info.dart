import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11367-169703&t=Igia83ug7FwBcS5m-4
abstract class GdsUserInfo {
  /// 닉네임, 댓글 개수, 좋아요 개수, 조회수 개수, 경과 시간 표시.
  static Widget normal({
    Key? key,
    String? nickname,
    int? likeCount,
    int? viewCount,
    int? commentCount,
    DateTime? date,
  }) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 4,
      children: GdsDot.separated([
        // 닉네임 표시.
        if (nickname != null) ...[
          Flexible(
            child: GdsText(
              nickname,
              color: .textGraySubtle,
              style: .label6,
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
        ],

        // 댓글 개수 표시.
        if (commentCount != null) ...[
          _iconLabel(icon: .chatRound, label: commentCount.compact),
        ],

        // 좋아요 개수 표시.
        if (likeCount != null) ...[
          _iconLabel(icon: .heart, label: likeCount.compact),
        ],

        // 조회수 개수 표시.
        if (viewCount != null) ...[
          _iconLabel(icon: .eye, label: viewCount.compact),
        ],

        // 경과 시간 표시.
        if (date != null) ...[
          GdsText(
            date.timeAgo,
            color: .textGraySubtle,
            style: .label6,
          ),
        ],
      ]),
    );
  }

  /// 닉네임, 경과 시간, 칩 표시.
  static Widget comment({
    Key? key,
    required String nickname,
    required bool isWriter,
    required DateTime date,
  }) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Row(
          mainAxisSize: .min,
          spacing: 4,
          children: [
            // 닉네임 표시.
            GdsText(nickname, color: .textGrayBold, style: .label5),

            // 칩 표시.
            if (isWriter) ...[
              GdsChip(label: '작성자', size: .md, variant: .primary),
            ],
          ],
        ),

        // 경과 시간 표시.
        GdsText(
          date.timeAgo,
          color: .textGraySubtle,
          style: .label6,
        ),
      ],
    );
  }

  /// 팔로워, 팔로잉 개수 표시.
  static Widget follow({
    Key? key,
    required int followerCount,
    required int followingCount,
    VoidCallback? onFollower,
    VoidCallback? onFollowing,
  }) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 8,
      children: [
        // 팔로워 표시.
        GdsGesture(
          onTap: onFollower,
          child: Row(
            mainAxisSize: .min,
            spacing: 2,
            children: [
              GdsText('팔로워', color: .textGrayNormal, style: .label6),
              GdsText(followerCount.compact, color: .textGrayBold, style: .label5),
            ],
          ),
        ),

        // 팔로잉 표시.
        GdsGesture(
          onTap: onFollowing,
          child: Row(
            mainAxisSize: .min,
            spacing: 2,
            children: [
              GdsText('팔로잉', color: .textGrayNormal, style: .label6),
              GdsText(followingCount.compact, color: .textGrayBold, style: .label5),
            ],
          ),
        ),
      ],
    );
  }

  /// 닉네임, 가격 표시.
  static Widget commission({
    Key? key,
    required String nickname,
    required int priceCount,
  }) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 4,
      children: GdsDot.separated([
        GdsText(nickname, color: .textGraySubtle, style: .label6),
        GdsText(priceCount.comma, color: .textGraySubtle, style: .label6),
      ]),
    );
  }

  /// 아이콘 옆에 라벨을 함께 표시합니다.
  static Widget _iconLabel({
    Key? key,
    required GdsIcon icon,
    required String label,
  }) {
    return Row(
      key: key,
      mainAxisSize: .min,
      spacing: 2,
      children: [
        icon.build(size: 16, color: .iconGraySubtle),
        GdsText(label, color: .textGraySubtle, style: .label6),
      ],
    );
  }
}
