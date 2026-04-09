part of '../gds_chat_bubble.dart';

class GdsChatSendingIcon extends StatelessWidget {
  const GdsChatSendingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GdsIcon.message.build(
      width: GdsIconSize.v16,
      height: GdsIconSize.v16,
      color: context.gdsColors.icon.graySubtler,
    );
  }
}
