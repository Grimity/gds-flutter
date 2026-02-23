import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsBookmarkType {
  defaultType,
  black;

  Color iconColor(GdsSemanticColor colors, bool isBookmarked) {
    if (isBookmarked) return colors.icon.primaryNormal;
    return switch (this) {
      GdsBookmarkType.defaultType => colors.icon.graySubtle,
      GdsBookmarkType.black => colors.icon.grayBold,
    };
  }
}

class GdsBookmark extends StatelessWidget {
  final GdsBookmarkType type;
  final bool isBookmarked;
  final VoidCallback onTap;

  const GdsBookmark({
    super.key,
    required this.isBookmarked,
    required this.onTap,
  }) : type = GdsBookmarkType.defaultType;

  const GdsBookmark.black({
    super.key,
    required this.isBookmarked,
    required this.onTap,
  }) : type = GdsBookmarkType.black;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = isBookmarked ? GdsIcon.bookmarkFill : GdsIcon.bookmarkOutline;

    return GdsIconAnimationButton(
      onTap: onTap,
      child: icon.build(
        color: type.iconColor(colors, isBookmarked),
        width: GdsIconSize.v24,
        height: GdsIconSize.v24,
      ),
    );
  }
}
