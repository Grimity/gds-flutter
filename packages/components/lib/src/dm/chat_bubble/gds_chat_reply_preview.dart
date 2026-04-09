part of '../gds_chat_bubble.dart';

class GdsChatReplyPreviewData {
  const GdsChatReplyPreviewData({
    required this.replyType,
    required this.replyLabel,
    required this.content,
  });

  final GdsChatMessageType replyType;
  final String replyLabel;
  final String content;
}

/// [messageType]은 현재 표시 중인 메시지의 작성자 타입입니다.
/// [replyType]은 답장 대상 메시지의 작성자 타입입니다.
///
/// 조합 예시
/// - 상대방 -> 상대방: [messageType] = other, [replyType] = other
/// - 나 -> 상대방: [messageType] = me, [replyType] = other
/// - 나 -> 나: [messageType] = me, [replyType] = me
/// - 상대방 -> 나: [messageType] = other, [replyType] = me
class GdsChatReplyPreview extends StatelessWidget {
  const GdsChatReplyPreview({
    super.key,
    required this.messageType,
    required this.replyType,
    required this.replyLabel,
    required this.content,
  });

  // 현재 메세지의 타입
  final GdsChatMessageType messageType;

  // (원본)답장 메세지의 타입
  final GdsChatMessageType replyType;

  // 답장 라벨
  final String replyLabel;

  // 원본 메세지
  final String content;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Align(
      alignment: messageType == GdsChatMessageType.other ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment: messageType == GdsChatMessageType.other ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        spacing: GdsSpacing.spacing6,
        children: [
          Align(
            widthFactor: 1,
            alignment: messageType == GdsChatMessageType.other ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              replyLabel,
              style: GdsTypography.label6.copyWith(
                color: colors.text.graySubtle,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: replyType == GdsChatMessageType.me ? MainAxisAlignment.end : MainAxisAlignment.start,
            spacing: GdsSpacing.spacing4,
            children: [
              GdsIcon.forward2.build(
                width: 18.0,
                height: 18.0,
                color: colors.icon.graySubtle,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: GdsSpacing.spacing10,
                    vertical: GdsSpacing.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: replyType.backgroundColor(colors),
                    borderRadius: BorderRadius.circular(GdsRadius.full),
                  ),
                  child: Text(
                    content,
                    style: GdsTypography.label4.copyWith(
                      color: replyType.textColor(
                        colors,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
