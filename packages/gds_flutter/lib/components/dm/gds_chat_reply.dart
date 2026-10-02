import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 답글 대상과 메시지를 표시하며 [GdsChatReply] 내부에서 사용되는 위젯.
class GdsChatReply extends StatelessWidget {
  const GdsChatReply({
    super.key,
    required this.isReplyToMe,
    required this.message,
    required this.nickname,
  });

  final bool isReplyToMe;
  final String message;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final isMine = context.findAncestorWidgetOfExactType<GdsChat>()?.isMine;
    if (isMine == null) {
      throw FlutterError(
        'GdsChatReply는 GdsChat 내부에서만 사용할 수 있습니다.'
        'GdsChat의 reply 속성으로 전달해 주세요.',
      );
    }

    return Column(
      crossAxisAlignment: isMine ? .end : .start,
      mainAxisSize: .min,
      spacing: 6,
      children: [
        // 답장 대상 표시
        GdsText(
          isReplyToMe ? '나에게 답장' : '[$nickname]님에게 답장',
          color: .textGraySubtle,
          style: .label6,
        ),

        // 메세지 본문 표시
        Row(
          mainAxisSize: .min,
          spacing: 4,
          children: [
            GdsIcon.forward2.build(size: 18, color: .iconGraySubtle),
            Flexible(
              child: GdsContainer(
                padding: .symmetric(vertical: 4, horizontal: 10),
                radius: .full,
                color: isReplyToMe ? .surfacePrimaryNormal : .surfaceGraySubtler,
                child: GdsText(
                  message,
                  color: .textGrayBold,
                  style: .label4,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
