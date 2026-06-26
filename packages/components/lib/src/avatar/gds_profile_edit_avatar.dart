import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

class GdsProfileEditAvatar extends StatelessWidget {
  const GdsProfileEditAvatar.xl({
    super.key,
    required this.imageUrl,
    required this.onTap,
  }) : size = GdsAvatarSize.xl;

  const GdsProfileEditAvatar.ml({
    super.key,
    required this.imageUrl,
    required this.onTap,
  }) : size = GdsAvatarSize.ml;

  final String? imageUrl;
  final GdsAvatarSize size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = GdsPersonAvatar(imageUrl: imageUrl, size: size);

    if (size == GdsAvatarSize.ml) {
      return GdsGesture(onTap: onTap, child: avatar);
    }

    final colors = context.gdsColors;
    final avatarSize = size.value;
    const overlapSpace = 8.0;

    return SizedBox(
      width: avatarSize + overlapSpace,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: GdsGesture(
              onTap: onTap,
              child: Container(
                width: GdsAtomicSpacing.v28,
                height: GdsAtomicSpacing.v28,
                decoration: BoxDecoration(
                  color: colors.surface.inverse,
                  borderRadius: BorderRadius.circular(GdsAtomicRadius.full),
                  border: Border.all(color: colors.surface.base, width: 2),
                ),
                child: Center(
                  child: GdsIcon.pen2Fill.build(
                    color: colors.icon.inverse,
                    width: 14,
                    height: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
