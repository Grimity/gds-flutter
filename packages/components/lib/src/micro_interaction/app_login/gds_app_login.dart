import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';

import 'app_login_infinite_scroll.dart';

/// 디자인 시스템의 앱 로그인 화면에서 사용되는 무한 스크롤 애니메이션 위젯
class GdsAppLogin extends StatelessWidget {
  const GdsAppLogin({
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
    // 스크린 너비에 따라 이미지 간 간격을 조정
    final spacing = GdsSpacing.spacing16 * (context.screenWidth / 768);

    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: Container(
        color: Color(0xFF232332),
        child: Row(
          spacing: spacing,
          children: [
            Expanded(
              child: AppLoginInfiniteScroll(
                velocity: velocity,
                spacing: spacing,
                images: [
                  GdsImage.appLogin1_1,
                  GdsImage.appLogin1_2,
                  GdsImage.appLogin1_3,
                  GdsImage.appLogin1_4,
                  GdsImage.appLogin1_5,
                ],
              ),
            ),
            Expanded(
              child: AppLoginInfiniteScroll(
                velocity: velocity,
                spacing: spacing,
                reverse: true,
                images: [
                  GdsImage.appLogin2_1,
                  GdsImage.appLogin2_2,
                  GdsImage.appLogin2_3,
                  GdsImage.appLogin2_4,
                  GdsImage.appLogin2_5,
                ],
              ),
            ),
            Expanded(
              child: AppLoginInfiniteScroll(
                velocity: velocity,
                spacing: spacing,
                images: [
                  GdsImage.appLogin3_1,
                  GdsImage.appLogin3_2,
                  GdsImage.appLogin3_3,
                  GdsImage.appLogin3_4,
                  GdsImage.appLogin3_5,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
