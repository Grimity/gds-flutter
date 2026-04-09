import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

part 'chat_bubble/gds_chat_sending_icon.dart';

part 'chat_bubble/gds_chat_heart_button.dart';

part 'chat_bubble/gds_chat_reply_button.dart';

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
    this.onHeartTap,
    this.onReplyTap,
    this.onImageTap,
    this.replyPreviewData,
  });

  final GdsChatMessageType type;
  final String? content;
  final String? imageUrl;
  final bool isLiked;
  final bool isSending;

  final VoidCallback? onHeartTap;
  final VoidCallback? onReplyTap;
  final VoidCallback? onImageTap;

  final GdsChatReplyPreviewData? replyPreviewData;

  @override
  State<GdsChatBubble> createState() => _GdsChatBubbleState();
}

class _GdsChatBubbleState extends State<GdsChatBubble> {
  static const double _replySlideThreshold = 40;
  static const double _replySlideOpenOffset = 40;
  static const Duration _replySlideAnimationDuration = Duration(milliseconds: 180);

  bool isLongPressed = false;
  bool _isReplySlideOpen = false;
  bool _wasReplySlideOpenAtDragStart = false;
  bool _isDraggingReplySlide = false;
  double _replySlideOffset = 0;

  bool get _hasContent => widget.content?.trim().isNotEmpty == true;

  bool get _hasImage => widget.imageUrl?.trim().isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (_hasContent)
        Flexible(
          child: GdsGesture(
            onLongPress: onChatLongPressed,
            onDoubleTap: widget.onHeartTap,
            child: GdsChatTextBubble(
              content: widget.content!,
              type: widget.type,
              isLiked: widget.isLiked,
            ),
          ),
        ),
      if (widget.isSending) const GdsChatSendingIcon(),
      if (isLongPressed)
        Row(
          spacing: GdsSpacing.spacing4,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GdsChatHeartButton(isLiked: widget.isLiked, onPressed: widget.onHeartTap),
            GdsChatReplyButton(onPressed: widget.onReplyTap),
          ],
        ),
    ];

    final messageRow = children.isNotEmpty
        ? Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.type == GdsChatMessageType.me ? MainAxisAlignment.end : MainAxisAlignment.start,
            spacing: GdsSpacing.spacing6,
            children: widget.type == GdsChatMessageType.me ? children.reversed.toList() : children,
          )
        : null;

    final slideMessageRow = messageRow == null
        ? const SizedBox.shrink()
        : GdsGesture(
            onHorizontalDragStart: widget.onReplyTap != null ? _handleReplySlideStart : null,
            onHorizontalDragUpdate: widget.onReplyTap != null ? _handleReplySlideUpdate : null,
            onHorizontalDragEnd: widget.onReplyTap != null ? _handleReplySlideEnd : null,
            onHorizontalDragCancel: widget.onReplyTap != null ? _handleReplySlideCancel : null,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: widget.type == GdsChatMessageType.me
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                spacing: GdsSpacing.spacing6,
                children: [
                  Flexible(
                    child: AnimatedContainer(
                      duration: _isDraggingReplySlide ? Duration.zero : _replySlideAnimationDuration,
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.translationValues(_replySlideOffset, 0, 0),
                      child: messageRow,
                    ),
                  ),
                  AnimatedSize(
                    duration: _replySlideAnimationDuration,
                    curve: Curves.easeOutCubic,
                    child: _isReplySlideOpen && widget.onReplyTap != null
                        ? GdsChatReplyButton(onPressed: _handleReplyButtonTap)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );

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
            slideMessageRow,
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

  void onChatLongPressed() {
    setState(() {
      _resetReplySlide();
      isLongPressed = !isLongPressed;
    });
  }

  void _handleReplySlideStart(DragStartDetails details) {
    setState(() {
      _wasReplySlideOpenAtDragStart = _isReplySlideOpen;
      _isDraggingReplySlide = true;
      isLongPressed = false;
    });
  }

  void _handleReplySlideUpdate(DragUpdateDetails details) {
    final nextOffset = (_replySlideOffset + details.delta.dx).clamp(
      -_replySlideOpenOffset,
      0.0,
    );

    if (nextOffset == _replySlideOffset) return;

    setState(() {
      _replySlideOffset = nextOffset;
    });
  }

  void _handleReplySlideEnd(DragEndDetails details) {
    final shouldOpen = _replySlideOffset <= -_replySlideThreshold;

    setState(() {
      _isDraggingReplySlide = false;

      if (_wasReplySlideOpenAtDragStart) {
        _resetReplySlide();
        return;
      }

      _isReplySlideOpen = shouldOpen;
      _replySlideOffset = 0;
    });
  }

  void _handleReplySlideCancel() {
    final shouldOpen = _replySlideOffset <= -_replySlideThreshold;

    setState(() {
      _isDraggingReplySlide = false;

      if (_wasReplySlideOpenAtDragStart) {
        _resetReplySlide();
        return;
      }

      _isReplySlideOpen = shouldOpen;
      _replySlideOffset = 0;
    });
  }

  void _handleReplyButtonTap() {
    setState(_resetReplySlide);
    widget.onReplyTap?.call();
  }

  void _resetReplySlide() {
    _isReplySlideOpen = false;
    _isDraggingReplySlide = false;
    _wasReplySlideOpenAtDragStart = false;
    _replySlideOffset = 0;
  }
}
