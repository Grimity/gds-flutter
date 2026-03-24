part of '../gds_chat_bubble.dart';

class GdsChatTextBubble extends StatelessWidget {
  const GdsChatTextBubble({
    super.key,
    required this.content,
    required this.type,
    this.isLiked = false,
  });

  final String content;
  final GdsChatMessageType type;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final bubble = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GdsSpacing.spacing12,
        vertical: GdsSpacing.spacing8,
      ),
      decoration: BoxDecoration(
        color: type.backgroundColor(colors),
        borderRadius: type.borderRadius,
      ),
      child: Text(
        content,
        style: GdsTypography.label2.copyWith(
          color: type.textColor(colors),
        ),
      ),
    );

    if (!isLiked) return bubble;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: GdsSpacing.spacing10),
          child: bubble,
        ),
        Positioned(
          left: type == GdsChatMessageType.other ? GdsSpacing.spacing8 : null,
          right: type == GdsChatMessageType.me ? GdsSpacing.spacing8 : null,
          bottom: 0,
          child: GdsChatFloatingHeartIcon(isLiked: isLiked),
        ),
      ],
    );
  }
}
