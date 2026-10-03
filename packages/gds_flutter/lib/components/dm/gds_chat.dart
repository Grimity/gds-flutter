import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 이미지, 답글과 말풍선을 발신자에 따라 정렬하여 표시하는 위젯.
class GdsChat extends StatelessWidget {
  const new({
    super.key,
    required this.isMine,
    this.reply,
    this.bubble,
    this.images,
  });

  final bool isMine;
  final GdsChatReply? reply;
  final GdsChatBubble? bubble;
  final GdsChatImages? images;

  @override
  Widget build(BuildContext context) {
    final children = [?images, ?reply, ?bubble];
    assert(children.isNotEmpty);

    return Column(
      crossAxisAlignment: isMine ? .end : .start,
      mainAxisSize: .min,
      spacing: 6,
      children: children,
    );
  }
}
