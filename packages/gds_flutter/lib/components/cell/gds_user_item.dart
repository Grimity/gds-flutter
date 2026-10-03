import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11481-167250&t=6LD6RMnOg9mBwzNp-4
abstract class GdsUserItem {
  /// 프로필, 닉네임, 핸들, 텍스트 버튼 목록을 표시하는 위젯.
  static Widget textButton({
    Key? key,
    required String nickname,
    String? handle,
    required ImageProvider? profile,
    required VoidCallback? onUser,
    List<GdsTextButtonAction>? actions,
  }) {
    return Padding(
      key: key,
      padding: 8.vertical,
      child: Row(
        spacing: 12,
        children: [
          info(
            nickname: nickname,
            profile: profile,
            handle: handle,
            onTap: onUser,
          ),

          // 우측 버튼 영역
          if (actions != null && actions.isNotEmpty) ...[
            Expanded(
              child: Row(
                mainAxisAlignment: .end,
                spacing: 8,
                children: actions.builder((action) {
                  return GdsButton.text(
                    type: action.type,
                    variant: action.variant,
                    size: .sm,
                    onTap: action.onTap,
                    label: action.label,
                  );
                }),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 프로필, 닉네임, 핸들, 아이콘 버튼 목록을 표시하는 위젯.
  static Widget iconButton({
    Key? key,
    required String nickname,
    String? handle,
    required ImageProvider? profile,
    required VoidCallback? onUser,
    List<GdsIconButtonAction>? actions,
  }) {
    return Padding(
      key: key,
      padding: 8.vertical,
      child: Row(
        spacing: 12,
        children: [
          info(
            nickname: nickname,
            profile: profile,
            handle: handle,
            onTap: onUser,
          ),

          // 우측 버튼 영역
          if (actions != null && actions.isNotEmpty) ...[
            Expanded(
              child: Row(
                mainAxisAlignment: .end,
                spacing: 8,
                children: actions.builder((action) {
                  return GdsButton.icon(
                    type: .normal,
                    icon: action.icon,
                    onTap: action.onTap,
                  );
                }),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 프로필, 닉네임, 핸들, 라디오를 표시하는 위젯.
  static Widget radio({
    Key? key,
    required bool value,
    required String nickname,
    String? handle,
    required ImageProvider? profile,
    required VoidCallback onTap,
  }) {
    return GdsGesture(
      key: key,
      onTap: onTap,
      child: Padding(
        padding: 8.vertical,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          spacing: 12,
          children: [
            info(
              nickname: nickname,
              profile: profile,
              handle: handle,
            ),

            // 우측 라디오 표시
            GdsRadio(value: value),
          ],
        ),
      ),
    );
  }

  /// 프로필, 닉네임, 팔로우 정보, 텍스트 버튼 목록을 표시하는 위젯.
  static Widget follow({
    Key? key,
    required int followerCount,
    required int followingCount,
    required String nickname,
    String? handle,
    required ImageProvider? profile,
    VoidCallback? onUser,
    List<GdsTextButtonAction> actions = const [],
  }) {
    return Padding(
      key: key,
      padding: 8.vertical,
      child: Row(
        spacing: 12,
        children: [
          _ProfileNickName(
            nickname: nickname,
            profile: profile,
            onTap: onUser,
            child: GdsUserInfo.follow(
              followerCount: followerCount,
              followingCount: followingCount,
            ),
          ),

          // 우측 버튼 영역
          if (actions.isNotEmpty) ...[
            Expanded(
              child: Row(
                mainAxisAlignment: .end,
                spacing: 8,
                children: actions.builder((action) {
                  return GdsButton.text(
                    type: action.type,
                    variant: action.variant,
                    size: .sm,
                    onTap: action.onTap,
                    label: action.label,
                  );
                }),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 알림 유형, 내용, 지난 시각, 읽음 여부를 표시하는 위젯.
  static Widget notification({
    Key? key,
    required String type,
    required String content,
    required DateTime createdAt,
    required bool read,
    required VoidCallback onClose,
  }) {
    return Padding(
      key: key,
      padding: 12.vertical,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        spacing: 12,
        children: [
          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              // 유형 표시
              GdsText(
                type,
                style: .label5,
                color: read ? .textGrayNormal : .textPrimaryNormal,
              ),
              2.verticalGap,

              // 본문 표시
              GdsText(
                content,
                style: .label4,
                color: read ? .textGraySubtle : .textGrayBold,
              ),
              8.verticalGap,

              // 지난 시각 표시
              GdsText(
                createdAt.timeAgo,
                style: .label6,
                color: .textGraySubtle,
              ),
            ],
          ),

          // 우측에 닫기 버튼 표시
          GdsButton.icon(
            icon: .x,
            type: .normal,
            onTap: onClose,
          ),
        ],
      ),
    );
  }

  /// 아이콘, 이름, 링크 주소를 표시하는 위젯.
  static Widget link({
    Key? key,
    required String name,
    required String? link,
    required GdsIcon icon,
    VoidCallback? onTap,
  }) {
    final hasLink = link != null;

    return GdsGesture(
      key: key,
      onTap: onTap,
      child: Padding(
        padding: hasLink ? 8.vertical : 4.vertical,
        child: Row(
          spacing: hasLink ? 12 : 4,
          children: [
            icon.build(
              size: hasLink ? 32 : 20,
              color: switch (icon.type) {
                .fixed => null,
                .themed => null,
                .semantic => .iconGraySubtle,
              },
            ),
            Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: 2,
              children: [
                // 링크 이름 표시
                GdsText(
                  name,
                  color: .textGrayBold,
                  style: hasLink ? .label3 : .label5,
                ),

                // 링크 주소 표시
                if (hasLink) ...[
                  GdsText(link, color: .textGraySubtle, style: .label6),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 게시글 유형, 제목, 내용, 메타데이터, 썸네일, 좋아요를 표시하는 위젯.
  static Widget post({
    Key? key,
    required String type,
    required String title,
    required DateTime createdAt,
    String? content,
    String? nickname,
    int? viewCount,
    int? commentCount,
    bool like = false,
    bool showImage = false,
    ImageProvider? image,
    GdsChipVariant chipVariant = .assistive,
    VoidCallback? onTap,
    VoidCallback? onLike,
  }) {
    final hasImage = image != null;
    final hasContent = content != null;
    final hasCommentCount = commentCount != null;

    return GdsGesture(
      key: key,
      onTap: onTap,
      child: GdsContainer(
        padding: hasContent ? 20.vertical : 12.vertical,
        border: .new(bottom: 1, color: GdsDividerVariant.secondary.color),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            // 좌측에 이미지 표시
            if (showImage) ...[
              Padding(
                padding: 12.right,
                child: GdsThumbnail(
                  ratio: .square,
                  radius: .sm,
                  border: .all(color: .borderGraySubtler),
                  width: 48,
                  height: 48,
                  provider: image,
                ),
              ),
            ],

            // 중앙에 제목 및 메타데이터 표시
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                spacing: 8,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          // 게시글 유형 표시
                          if (!showImage) ...[
                            GdsChip(variant: chipVariant, size: .md, label: type),
                          ],

                          // 이미지 포함 여부를 아이콘으로 표시
                          if (!showImage && hasImage) ...[
                            GdsIcon.galleryFill.build(size: 16, color: .iconGraySubtle),
                          ],

                          // 게시글 제목 표시
                          Flexible(
                            fit: FlexFit.loose,
                            child: GdsText(
                              title,
                              color: .textGrayBold,
                              style: .label1,
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                          ),

                          // 게시글의 댓글 수를 배지로 표시
                          if (hasContent && hasCommentCount) ...[
                            GdsPushBadge.number(variant: .outline, value: commentCount),
                          ],
                        ],
                      ),

                      // 최대 2줄의 게시글 본문 표시
                      if (hasContent) ...[
                        GdsText(
                          content,
                          color: .textGrayBold,
                          style: .body2R,
                          maxLines: 2,
                          overflow: .ellipsis,
                        ),
                      ],
                    ],
                  ),

                  // 메타데이터 표시
                  GdsUserInfo.normal(
                    nickname: hasContent ? nickname : null,
                    viewCount: viewCount,
                    commentCount: hasContent ? null : commentCount,
                    date: createdAt,
                  ),
                ],
              ),
            ),

            // 우측에 좋아요 버튼 표시
            if (onLike != null) ...[
              Padding(
                padding: 20.left,
                child: GdsHeart(
                  value: like,
                  black: false,
                  onChanged: (_) => onLike(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 프로필, 작성자 정보, 댓글 내용, 좋아요, 답글 액션을 표시하는 위젯.
  @GdsSupportedSizes([.md, .xs])
  static Widget comment({
    Key? key,
    required GdsSize size,
    required String nickname,
    required int likeCount,
    required bool isWriter, // 작성자인지 여부
    required bool isReply, // 답글인지 여부
    required bool isLiked, // 현재 사용자가 좋아요를 눌렀는지 여부
    required String content,
    required String? mention,
    required ImageProvider? profile,
    required DateTime createdAt,
    required VoidCallback onMenu,
    required VoidCallback onLike,
    required VoidCallback onReply,
  }) {
    final profileWidth = GdsProfile.getDimension(size);
    final hasMention = mention != null;

    return Padding(
      key: key,
      padding: .only(left: isReply ? 32 : 0),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        spacing: 4,
        children: [
          Row(
            spacing: 8,
            children: [
              // 답글에 대한 마크 표시
              if (isReply) ...[
                GdsContainer(
                  width: 10,
                  height: 10,
                  border: .new(
                    left: 1,
                    bottom: 1,
                    color: .borderGraySubtle,
                  ),
                ),
              ],

              // 작성자 정보 표시
              GdsProfile(size: size, image: profile),
              GdsUserInfo.comment(
                nickname: nickname,
                isWriter: isWriter,
                date: createdAt,
              ),

              // 우측 상단에 메뉴 버튼 표시
              Expanded(
                child: Align(
                  alignment: .centerRight,
                  child: GdsButton.icon(
                    type: .sm,
                    icon: .dotmenuHorizontal,
                    onTap: onMenu,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: .only(left: profileWidth + 8),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: size.when(md: 12, xs: 6),
              children: [
                // 중간에 댓글 내용 표시
                Builder(
                  builder: (context) {
                    return GdsText.rich(
                      TextSpan(
                        children: [
                          // 멘션 라벨 표시
                          if (hasMention) ...[
                            GdsTextSpan(
                              '@$mention',
                              context,
                              color: .textPrimaryNormal,
                              style: .label5,
                            ),
                          ],

                          // 댓글 본문 표시
                          GdsTextSpan(' $content', context),
                        ],
                      ),
                      color: .textGrayBold,
                      style: .body2R,
                    );
                  },
                ),

                // 아래에 액션 버튼 표시
                Row(
                  spacing: 10,
                  children: [
                    // 좋아요 버튼 표시
                    GdsButton.text(
                      size: .sm,
                      type: .borderless,
                      variant: .assistive,
                      leadingIcon: isLiked ? .heartFill : .heart,
                      label: likeCount.toString(),
                      onTap: onLike,
                    ),

                    // 답글달기 버튼 표시
                    GdsButton.text(
                      size: .sm,
                      type: .borderless,
                      variant: .assistive,
                      leadingIcon: .chatRound,
                      label: '답글달기',
                      onTap: onReply,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 삭제된 댓글 안내 문구를 표시하는 위젯.
  static Widget commentDeleted({Key? key}) {
    return Padding(
      key: key,
      padding: .symmetric(vertical: 8),
      child: Row(
        children: [
          GdsText(
            '삭제된 댓글입니다.',
            color: .textGraySubtle,
            style: .label6,
          ),
        ],
      ),
    );
  }

  /// 프로필 이미지와 닉네임 및 조건부 핸들을 표시하는 위젯.
  static Widget info({
    Key? key,
    required String nickname,
    required ImageProvider? profile,
    String? handle,
    VoidCallback? onTap,
  }) {
    return _ProfileNickName(
      key: key,
      nickname: nickname,
      profile: profile,
      onTap: onTap,
      child: handle != null ? GdsText('@$handle', color: .textGraySubtle, style: .label6) : null,
    );
  }
}

/// 프로필 이미지와 닉네임 및 부가 정보를 표시하는 위젯.
class _ProfileNickName extends StatelessWidget {
  const new({
    super.key,
    required this.nickname,
    required this.profile,
    this.child,
    this.onTap,
  });

  final String nickname;
  final ImageProvider? profile;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      key: key,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: 8,
        children: [
          GdsProfile(size: .md, image: profile),
          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 2,
            children: [
              GdsText(nickname, color: .textGrayBold, style: .label3),
              ?child,
            ],
          ),
        ],
      ),
    );
  }
}
