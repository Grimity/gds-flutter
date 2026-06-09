import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

part 'chat_bubble/gds_chat_sending_icon.dart';
part 'chat_bubble/gds_chat_floating_heart_icon.dart';
part 'chat_bubble/gds_chat_message_type.dart';
part 'chat_bubble/gds_chat_text_bubble.dart';
part 'chat_bubble/gds_chat_reply_preview.dart';
part 'chat_bubble/gds_chat_image.dart';

class GdsChatBubble extends StatefulWidget {
  const GdsChatBubble({
    super.key,
    required this.type,
    required this.content,
    required this.imageUrl,
    this.isLiked = false,
    this.isSending = false,
    this.onTap,
    this.onHeartTap,
    this.onImageTap,
    this.replyPreviewData,
  });

  final GdsChatMessageType type;
  final String? content;
  final String? imageUrl;
  final bool isLiked;
  final bool isSending;

  final VoidCallback? onTap;
  final VoidCallback? onHeartTap;
  final VoidCallback? onImageTap;

  final GdsChatReplyPreviewData? replyPreviewData;

  @override
  State<GdsChatBubble> createState() => _GdsChatBubbleState();
}

class _GdsChatBubbleState extends State<GdsChatBubble> {
  bool get _hasContent => widget.content?.trim().isNotEmpty == true;
  bool get _hasImage => widget.imageUrl?.trim().isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (_hasContent)
        Flexible(
          child: GdsGesture(
            onTap: widget.onTap,
            child: GdsChatTextBubble(
              content: widget.content!,
              type: widget.type,
              isLiked: widget.isLiked,
            ),
          ),
        ),
      if (widget.isSending) const GdsChatSendingIcon(),
    ];

    final messageRow = children.isNotEmpty
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: widget.type == GdsChatMessageType.me ? MainAxisAlignment.end : MainAxisAlignment.start,
            spacing: GdsSpacing.spacing6,
            children: widget.type == GdsChatMessageType.me ? children.reversed.toList() : children,
          )
        : null;

    return Padding(
      padding: widget.type.margin(context),
      child: Align(
        alignment: widget.type.alignment,
        child: Column(
          spacing: GdsSpacing.spacing6,
          crossAxisAlignment: widget.type.crossAxisAlignment,
          children: [
            if (widget.replyPreviewData != null)
              GdsChatReplyPreview(
                messageType: widget.type,
                replyType: widget.replyPreviewData!.replyType,
                replyLabel: widget.replyPreviewData!.replyLabel,
                content: widget.replyPreviewData!.content,
              ),
            messageRow ?? const SizedBox.shrink(),
            if (_hasImage)
              GdsGesture(
                onTap: widget.onImageTap,
                child: GdsChatImage(
                  imageUrl: widget.imageUrl!,
                  type: widget.type,
                  isLiked: widget.isLiked,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
