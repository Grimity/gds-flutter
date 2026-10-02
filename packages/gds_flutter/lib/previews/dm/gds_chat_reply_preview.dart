import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsChatReply]에 대한 프리뷰 위젯.
class GdsChatReplyPreview extends PreviewWidget {
  final isMineControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Is Mine',
  );

  final isReplyToMeControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Is Reply To Me',
  );

  final messageControl = PreviewControl.string(
    defaultValue: '여기에 메세지 답글이 표시됩니다.',
    displayName: 'Message',
  );

  final nicknameControl = PreviewControl.string(
    defaultValue: 'User',
    displayName: 'Nickname',
  );

  @override
  String get displayName => 'Chat Reply';

  @override
  List<String> get groups => ['DM'];

  @override
  Widget build(BuildContext context) {
    final isMine = isMineControl.of(context);
    final isReplyToMe = isReplyToMeControl.of(context);
    final message = messageControl.of(context);
    final nickname = nicknameControl.of(context);

    return GdsChat(
      isMine: isMine.value,
      reply: .new(
        isReplyToMe: isReplyToMe.value,
        message: message.value,
        nickname: nickname.value,
      ),
    );
  }
}
