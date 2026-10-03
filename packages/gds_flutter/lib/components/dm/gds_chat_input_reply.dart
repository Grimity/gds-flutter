import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 답글 대상의 닉네임과 메시지를 표시하며 채팅 입력 필드에서 사용되는 위젯.
class GdsChatInputReply extends StatelessWidget {
  const new({
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
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: 4,
      children: [
        // 헤더 표시
        Row(
          spacing: 2,
          children: [
            GdsIcon.forward2.build(size: 16, color: .iconGraySubtle),
            GdsText(
              isReplyToMe ? '나에게 답장' : '[$nickname]님에게 답장',
              color: .textGraySubtle,
              style: .label6,
              maxLines: 1,
            ),
          ],
        ),

        // 메세지 표시
        GdsText(message, color: .textGrayBold, style: .label4),
      ],
    );
  }
}
