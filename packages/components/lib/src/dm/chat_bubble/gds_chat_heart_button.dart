part of '../gds_chat_bubble.dart';

class GdsChatHeartButton extends StatelessWidget {
  const GdsChatHeartButton({
    super.key,
    required this.isLiked,
    required this.onPressed,
  });

  final bool isLiked;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final icon = GdsHeart.icon(isLiked);

    return GdsIconButton.outlined(
      icon: icon,
      onPressed: onPressed,
      iconColor: GdsHeartType.black.iconColor(colors, isLiked),
    );
  }
}
