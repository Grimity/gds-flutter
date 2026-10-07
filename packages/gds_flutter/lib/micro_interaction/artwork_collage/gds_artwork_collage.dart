import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 주로 로그인 페이지에서 사용되는 메이슨리 이미지 배경 위젯.
class GdsArtworkCollage extends StatelessWidget {
  const new({
    super.key,
    this.velocity = 5.0,
    this.scale = 1.15,
  });

  /// 스크롤 속도 (픽셀/초 단위)
  final double velocity;

  // 화면 확대 비율
  final double scale;

  @override
  Widget build(BuildContext context) {
    // 스크린 너비에 따라 이미지 간 간격을 조정.
    final spacing = 16 * (context.viewport.width / GdsBreakpoint.sm.minWidth);

    return Transform.scale(
      scale: scale,
      alignment: .center,
      child: ColoredBox(
        color: Color(0xFF232332),
        child: Row(
          spacing: spacing,
          children: [
            Expanded(
              child: GdsArtworkCollageScroll(
                velocity: velocity,
                spacing: spacing,
                images: [
                  imageOf(1, 1),
                  imageOf(1, 2),
                  imageOf(1, 3),
                  imageOf(1, 4),
                  imageOf(1, 5),
                ],
              ),
            ),
            Expanded(
              child: GdsArtworkCollageScroll(
                velocity: velocity,
                spacing: spacing,
                reverse: true,
                images: [
                  imageOf(2, 1),
                  imageOf(2, 2),
                  imageOf(2, 3),
                  imageOf(2, 4),
                  imageOf(2, 5),
                ],
              ),
            ),
            Expanded(
              child: GdsArtworkCollageScroll(
                velocity: velocity,
                spacing: spacing,
                images: [
                  imageOf(3, 1),
                  imageOf(3, 2),
                  imageOf(3, 3),
                  imageOf(3, 4),
                  imageOf(3, 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  static AssetImage imageOf(int a, int b) {
    return .new('assets/images/artwork_collage/$a-$b.png', package: 'gds_flutter');
  }
}
