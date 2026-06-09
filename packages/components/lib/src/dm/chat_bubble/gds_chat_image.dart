part of '../gds_chat_bubble.dart';

/// TODO 이미지 캐싱 처리
class GdsChatImage extends StatelessWidget {
  const GdsChatImage({
    super.key,
    required this.imageUrl,
    required this.type,
    this.isLiked = false,
  });

  final String imageUrl;
  final GdsChatMessageType type;
  final bool isLiked;

  static const double width = 300;

  @override
  Widget build(BuildContext context) {
    final chatImage = ClipRRect(
      borderRadius: BorderRadius.circular(GdsRadius.sm),
      child: SizedBox(
        width: width,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );

    if (!isLiked) return chatImage;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: GdsSpacing.spacing10),
          child: chatImage,
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
