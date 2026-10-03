import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 사용자 카드에 표시할 썸네일 정보.
typedef GdsUserThumbnail = ({
  ImageProvider image,
  bool like,
  ValueChanged<bool> onLike,
});

/// 사용자 정보를 다양한 형태의 카드로 표시하는 위젯을 제공합니다.
abstract class GdsUser {
  /// 사용자 정보와 최근 작품 썸네일을 포함하여 추천 시 사용되는 위젯.
  static Widget normal({
    Key? key,
    required int followerCount,
    required int followingCount,
    required String nickname,
    required ImageProvider? profile,
    required List<GdsUserThumbnail> thumbnails,
    required bool following,
    required VoidCallback onTap,
    required VoidCallback onFollow,
    required VoidCallback onUnFollow,
  }) {
    return GdsGesture(
      key: key,
      onTap: onTap,
      child: GdsContainer(
        width: 360,
        border: .all(color: .borderGraySubtle),
        radius: .md,
        padding: .all(16),
        child: Column(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            // 사용자 정보 표시
            GdsUserItem.follow(
              followerCount: followerCount,
              followingCount: followingCount,
              nickname: nickname,
              profile: profile,
              actions: [
                .follow(
                  following: following,
                  onFollow: onFollow,
                  onUnFollow: onUnFollow,
                ),
              ],
            ),

            // 썸네일 3개 표시
            Row(
              spacing: 8,
              children: .generate(3, (index) {
                final thumbnail = thumbnails.elementAtOrNull(index);

                return Expanded(
                  child: Stack(
                    children: [
                      // 이미지 표시
                      GdsThumbnail(
                        ratio: .square,
                        radius: .sm,
                        provider: thumbnail?.image,
                      ),

                      // 좋아요 버튼 표시
                      if (thumbnail != null) ...[
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: GdsHeart(
                            value: thumbnail.like,
                            black: false,
                            onChanged: thumbnail.onLike,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 사용자의 배너, 소개글, 팔로우 기능을 포함하여 검색 시 사용되는 위젯.
  static Widget search({
    Key? key,
    required String nickname,
    required String introduction,
    required int followerCount,
    required ImageProvider? profile,
    required ImageProvider? banner,
    required bool following,
    required VoidCallback onTap,
    required VoidCallback onFollow,
    required VoidCallback onUnFollow,
  }) {
    final followAction = GdsTextButtonAction.follow(
      following: following,
      onFollow: onFollow,
      onUnFollow: onUnFollow,
    );

    return GdsGesture(
      key: key,
      onTap: onTap,
      child: GdsContainer(
        width: 360,
        radius: .md,
        border: .all(color: .borderGraySubtle),
        clip: true,
        child: Column(
          mainAxisSize: .min,
          children: [
            // 배너 이미지 표시
            GdsThumbnail(ratio: .banner, provider: banner),

            // 그 외 본문 표시
            Transform.translate(
              offset: .new(0, -16),
              child: Padding(
                padding: .symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  spacing: 12,
                  children: [
                    // 사용자 정보 표시
                    Row(
                      crossAxisAlignment: .end,
                      mainAxisAlignment: .spaceBetween,
                      spacing: 12,
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            // 프로필 이미지 표시
                            GdsProfile(size: .md, image: profile),
                            8.verticalGap,

                            // 사용자 이름 표시
                            GdsText(nickname, color: .textGrayBold, style: .label1),
                            2.verticalGap,

                            // 팔로워 수 표시
                            Row(
                              spacing: 2,
                              children: [
                                GdsText('팔로워', color: .textGrayNormal, style: .label6),
                                GdsText(followerCount.compact, color: .textGrayBold, style: .label5),
                              ],
                            ),
                          ],
                        ),

                        // 팔로잉 버튼 표시
                        GdsButton.text(
                          type: followAction.type,
                          size: .sm,
                          label: followAction.label,
                          onTap: followAction.onTap,
                        ),
                      ],
                    ),

                    // 소개글 최대 2줄 표시
                    GdsText(
                      introduction,
                      color: .textGrayNormal,
                      style: .body2R,
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 태그 명, 이미지를 포함하여 가장 인기 있는 태그가 표시될 때 사용되는 위젯.
  static Widget tagView({
    Key? key,
    required String content,
    required ImageProvider? thumbnail,
  }) {
    return SizedBox(
      key: key,
      width: 180,
      child: ClipRRect(
        borderRadius: GdsRadius.md.all,
        child: Stack(
          children: [
            // 이미지 표시
            GdsThumbnail(ratio: .portrait, provider: thumbnail),

            // 그라디언트 오버레이 표시
            Positioned.fill(
              child: GdsContainer(
                padding: .all(16),
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    GdsAtomicColor.transparent,
                    GdsAtomicColor.black,
                  ],
                ),
                alignment: .bottomLeft,
                child: GdsText(
                  content,
                  color: .textWhite,
                  style: .body1SB,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
