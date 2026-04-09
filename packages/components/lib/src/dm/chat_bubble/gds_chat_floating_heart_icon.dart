part of '../gds_chat_bubble.dart';

class GdsChatFloatingHeartIcon extends StatelessWidget {
  const GdsChatFloatingHeartIcon({super.key, required this.isLiked});

  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = GdsHeart.icon(isLiked);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface.base,
        borderRadius: BorderRadius.circular(GdsRadius.full),
        border: Border.all(
          width: 1,
          color: colors.border.graySubtler,
        ),
      ),
      padding: EdgeInsets.all(GdsSpacing.spacing4),
      child: icon.build(
        width: GdsIconSize.v12,
        height: GdsIconSize.v12,
        color: GdsHeartType.black.iconColor(colors, isLiked),
      ),
    );
  }
}
