part of '../gds_chat_bubble.dart';

class GdsChatTextBubble extends StatelessWidget {
  const GdsChatTextBubble({
    super.key,
    required this.content,
    required this.type,
    this.isLiked = false,
    this.maxWidth = double.infinity,
  });

  final String content;
  final GdsChatMessageType type;
  final bool isLiked;
  final double maxWidth;

  static final RegExp _longTokenPattern = RegExp(r'\S{24,}');
  static const int _maxTokenChunkLength = 16;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: GdsSpacing.spacing12,
          vertical: GdsSpacing.spacing8,
        ),
        decoration: BoxDecoration(
          color: type.backgroundColor(colors),
          borderRadius: type.borderRadius,
        ),
        child: Text(
          _insertBreakOpportunities(content),
          softWrap: true,
          overflow: TextOverflow.clip,
          style: GdsTypography.label2.copyWith(
            color: type.textColor(colors),
          ),
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

  static String _insertBreakOpportunities(String value) {
    return value.replaceAllMapped(_longTokenPattern, (match) {
      final token = match.group(0)!;
      final buffer = StringBuffer();
      var index = 0;

      for (final rune in token.runes) {
        if (index > 0 && index % _maxTokenChunkLength == 0) {
          buffer.write('\u200B');
        }
        buffer.writeCharCode(rune);
        index++;
      }

      return buffer.toString();
    });
  }
}
