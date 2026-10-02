import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsChatBubble]에 대한 프리뷰 위젯.
class GdsChatBubblePreview extends PreviewWidget {
  final isMineControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Is Mine',
  );

  final messageControl = PreviewControl.string(
    defaultValue: '여기에 메세지 본문이 표시됩니다.',
    displayName: 'Message',
  );

  final sendControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Send',
  );

  final likeControl = PreviewControl.boolean(
    defaultValue: false,
    displayName: 'Like',
  );

  @override
  String get displayName => 'Chat Bubble';

  @override
  List<String> get groups => ['DM'];

  @override
  Widget build(BuildContext context) {
    final isMine = isMineControl.of(context);
    final message = messageControl.of(context);
    final send = sendControl.of(context);
    final like = likeControl.of(context);

    return GdsChat(
      isMine: isMine.value,
      bubble: .new(
        message: message.value,
        send: send.value,
        like: like.value,
        onLike: () => debugPrint('onLike() called'),
        onReply: () => debugPrint('onReply() called'),
      ),
    );
  }
}
