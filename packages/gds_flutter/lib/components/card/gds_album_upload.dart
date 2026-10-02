import 'package:flutter/material.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 앨범 이미지 업로드에 사용하는 여러 앨범 위젯을 제공합니다.
abstract class GdsAlbumUpload {
  /// 이미지 업로드 안내를 표시하는 플레이스홀더 위젯.
  @GdsSupportedSizes([.lg, .md])
  static Widget placeholder({
    Key? key,
    required GdsSize size,
    required VoidCallback onTap,
  }) {
    return GdsGesture(
      onTap: onTap,
      child: SizedBox(
        key: key,
        width: size.when(lg: 200, md: 160),
        child: Column(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            AspectRatio(
              aspectRatio: GdsThumbnailRatio.square.value,
              child: GdsContainer(
                border: .all(color: .borderGraySubtler),
                radius: .md,
                color: .bgSecondary,
                alignment: .center,
                child: Column(
                  mainAxisSize: .min,
                  spacing: 12,
                  children: [
                    // 일러스트용 아이콘 표시
                    GdsIcon.gallery.build(
                      size: size.when(lg: 40, md: 32),
                      color: .iconGraySubtle,
                    ),

                    // 설명 표시
                    GdsText(
                      'JPG / PNG\n1장 당 10MB 이내\n최대 10장까지 업로드',
                      color: .textGraySubtle,
                      style: .label4,
                      textAlign: .center,
                    ),
                  ],
                ),
              ),
            ),

            // 빈 제목 표시
            GdsText('', color: .textGrayBold, style: .label2),
          ],
        ),
      ),
    );
  }

  /// 이미지, 선택 기능과 삭제 버튼을 표시하는 업로드 이미지 위젯.
  static Widget image({
    Key? key,
    required GdsSize size,
    required ImageProvider image,
    required String title,
    required bool checked,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return GdsGesture(
      onTap: onTap,
      child: SizedBox(
        key: key,
        width: size.when(lg: 200, md: 160),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Stack(
              children: [
                // 이미지 표시
                GdsContainer(
                  border: checked ? .all(width: 2, color: .borderPrimaryNormal) : null,
                  radius: .md,
                  clip: true,
                  child: GdsThumbnail(ratio: .square, provider: image),
                ),

                // 메인 이미지 배지 표시
                Positioned(
                  top: 8,
                  left: 8,
                  child: _MainImageBadge(size: size, value: checked),
                ),

                // 제거 버튼 표시
                Positioned(
                  top: 8,
                  right: 8,
                  child: _IconButton(icon: .x, onTap: onRemove),
                ),
              ],
            ),

            // 제목 표시
            GdsText(
              title,
              color: .textGrayBold,
              style: .label2,
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// 이미지와 선택 시 앨범 개수 배지를 표시하는 앨범 위젯.
  static Widget album({
    Key? key,
    required ImageProvider image,
    required int count,
    required bool checked,
    required VoidCallback onTap,
  }) {
    return GdsGesture(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: ClipRRect(
          key: key,
          borderRadius: GdsRadius.md.all,
          child: Stack(
            children: [
              // 이미지 표시
              GdsThumbnail(ratio: .square, provider: image),

              // 그라데이션 표시
              Positioned.fill(
                child: GdsFadable.builder(
                  type: .fade,
                  visible: checked,
                  builder: (context) {
                    // ignore: gds_lints/prefer_gds_container
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: .topCenter,
                          end: .bottomCenter,
                          colors: [
                            GdsAtomicColor.black,
                            GdsAtomicColor.transparent,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 카운트 배지 표시
              Positioned(
                top: 8,
                right: 8,
                child: GdsFadable.builder(
                  type: .scaleFade,
                  visible: checked,
                  builder: (context) {
                    return GdsPushBadge.number(variant: .text, value: count);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 선택 여부를 표시하는 메인 이미지 배지 위젯.
@GdsSupportedSizes([.lg, .md])
class _MainImageBadge extends StatelessWidget {
  const _MainImageBadge({
    required this.size,
    required this.value,
  });

  final GdsSize size;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      radius: .full,
      border: value ? null : .all(color: .borderGraySubtler),
      color: value ? .surfacePrimaryNormal : .surfaceBase,
      padding: size.when(
        lg: .symmetric(vertical: 6, horizontal: 10),
        md: .symmetric(vertical: 4, horizontal: 8),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: size.when(lg: 4, md: 2),
        children: [
          // 아이콘 표시
          GdsIcon.check.build(
            size: size.when(lg: 16, md: 12),
            color: value ? .iconWhite : .iconGraySubtle,
          ),

          // 텍스트 표시
          GdsText(
            '대표',
            color: value ? .textWhite : .textGraySubtle,
            style: size.when(lg: .label4, md: .label6),
          ),
        ],
      ),
    );
  }
}

/// 탭 동작을 처리하는 앨범 업로드용 아이콘 버튼 위젯.
class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
  });

  final GdsIcon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: GdsRadius.sm.all,
        child: BackdropFilter(
          filter: .blur(sigmaX: 10, sigmaY: 10),
          child: GdsContainer(
            padding: .all(4),
            color: .bgOverlayBlack,
            child: icon.build(size: 16, color: .iconWhite),
          ),
        ),
      ),
    );
  }
}
