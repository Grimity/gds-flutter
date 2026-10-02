import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 사용자 프로필 이미지에 편집 기능을 제공하는 위젯.
@GdsSupportedSizes([.xl, .ml])
class GdsProfileEdit extends StatelessWidget {
  const GdsProfileEdit({
    super.key,
    required this.size,
    required this.url,
    this.onTap,
  });

  final GdsSize size;
  final String? url;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GdsGesture(
      onTap: onTap,
      child: Stack(
        clipBehavior: .none,
        children: [
          GdsProfile(size: size, url: url),

          // 우측 하단에 아이콘 배지 표시
          if (size == .xl) ...[
            Positioned(
              right: -8,
              bottom: 0,
              child: buildIconBadge(context),
            ),
          ],
        ],
      ),
    );
  }

  /// 프로필 편집을 나타내는 아이콘 배지를 표시하는 위젯.
  Widget buildIconBadge(BuildContext context) {
    return GdsContainer(
      width: 28,
      height: 28,
      color: .surfaceInverse,
      shape: .circle,
      alignment: Alignment.center,

      // ignore: gds_lints/valid_gds_spacing
      child: GdsIcon.pen2Fill.build(size: 14, color: .iconInverse),
    );
  }
}
