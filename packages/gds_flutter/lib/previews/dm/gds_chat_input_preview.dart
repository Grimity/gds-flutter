import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsChatInput]에 대한 프리뷰 위젯.
class GdsChatInputPreview extends PreviewWidget {
  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  final showReplyControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Show Reply',
  );

  final isReplyToMeControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Is Reply To Me',
  );

  final nicknameControl = PreviewControl.string(
    defaultValue: 'User',
    displayName: 'Reply Nickname',
  );

  final messageControl = PreviewControl.string(
    defaultValue: '답장할 메시지가 여기에 표시됩니다.',
    displayName: 'Reply Message',
  );

  @override
  String get displayName => 'Chat Input';

  @override
  List<String> get groups => ['DM'];

  @override
  Widget build(BuildContext context) {
    final enabled = enabledControl.of(context);
    final showReply = showReplyControl.of(context);
    final isReplyToMe = isReplyToMeControl.of(context);
    final message = messageControl.of(context);
    final nickname = nicknameControl.of(context);

    final reply = GdsChatInputReply(
      isReplyToMe: isReplyToMe.value,
      message: message.value,
      nickname: nickname.value,
    );

    return GdsChatInput(
      enabled: enabled.value,
      reply: showReply.value ? reply : null,
      onCameraTap: () => debugPrint('onCameraTap() called'),
      onSubmit: () => debugPrint('onSubmit() called'),
    );
  }
}
