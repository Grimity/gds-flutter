import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsHeartType {
  defaultType,
  black;

  Color iconColor(GdsSemanticColor colors, bool isLiked) {
    if (isLiked) return colors.status.notification;
    return switch (this) {
      GdsHeartType.defaultType => colors.icon.graySubtle,
      GdsHeartType.black => colors.icon.grayBold,
    };
  }
}

class GdsHeart extends StatelessWidget {
  final GdsHeartType type;
  final bool isLiked;
  final VoidCallback onTap;

  const GdsHeart({
    super.key,
    required this.isLiked,
    required this.onTap,
  }) : type = GdsHeartType.defaultType;

  const GdsHeart.black({
    super.key,
    required this.isLiked,
    required this.onTap,
  }) : type = GdsHeartType.black;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = isLiked ? GdsIcon.heartFill : GdsIcon.heartOutline;

    return GdsIconAnimationButton(
      onTap: onTap,
      child: icon.build(
        color: type.iconColor(colors, isLiked),
        width: GdsIconSize.v24,
        height: GdsIconSize.v24,
      ),
    );
  }
}
