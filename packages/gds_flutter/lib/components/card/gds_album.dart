import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 앨범 이미지, 제목, 작성자 정보와 상태별 액션을 표시하는 카드 위젯.
class GdsAlbum extends StatelessWidget {
  const new({
    super.key,
    required this.image,
    required this.title,
    required this.nickname,
    required this.likeCount,
    required this.viewCount,
    this.rank,
    this.like,
    this.checked,
    this.onTap,
    this.onLike,
  });

  final ImageProvider? image;
  final String title;
  final String nickname;
  final int likeCount;
  final int viewCount;
  final int? rank;
  final bool? like;
  final bool? checked;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onLike;

  @override
  Widget build(BuildContext context) {
    final hasLike = like != null;
    final hasChecked = checked != null;

    // 선택 상태에 따른 이미지 테두리.
    final GdsBorder imageBorder = .all(
      width: 2,
      color: (checked ?? false) ? .borderPrimaryNormal : .borderGraySubtle,
    );

    /// 랭크 배지 아이콘.
    final rankIcon = switch (rank) {
      1 => GdsIcon.rank1,
      2 => GdsIcon.rank2,
      3 => GdsIcon.rank3,
      4 => GdsIcon.rank4,
      _ => null,
    };

    return GdsGesture(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: 12,
        children: [
          Stack(
            children: [
              // 이미지 표시
              GdsContainer(
                border: hasChecked ? imageBorder : null,
                radius: .md,
                clip: true,
                child: GdsThumbnail(ratio: .square, provider: image),
              ),

              // 체크 박스 표시
              Positioned(
                top: 8,
                right: 8,
                child: GdsFadable.builder(
                  type: .scaleFade,
                  visible: hasChecked,
                  builder: (context) {
                    return GdsCheckBox(size: .md, value: checked!);
                  },
                ),
              ),

              // 좋아요 버튼 표시
              Positioned(
                bottom: 8,
                right: 8,
                child: GdsFadable.builder(
                  type: .scaleFade,
                  visible: hasLike,
                  builder: (context) {
                    return GdsHeart(
                      value: like!,
                      black: false,
                      onChanged: onLike,
                    );
                  },
                ),
              ),

              // 랭크 배지 표시
              if (rankIcon != null) ...[
                Positioned(
                  top: 8,
                  left: 8,
                  child: rankIcon.build(size: 24),
                ),
              ],
            ],
          ),

          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 4,
            children: [
              // 제목 표시
              GdsText(
                title,
                color: .textGrayBold,
                style: .label2,
                maxLines: 1,
                overflow: .ellipsis,
              ),

              // 관련 정보 표시
              GdsUserInfo.normal(
                nickname: nickname,
                likeCount: likeCount,
                viewCount: viewCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
