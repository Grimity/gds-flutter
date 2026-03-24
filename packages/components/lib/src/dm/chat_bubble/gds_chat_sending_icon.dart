part of '../gds_chat_bubble.dart';

/// TODO Sending 아이콘 Atomic 아이콘에 추가 후 변경 필요
class GdsChatSendingIcon extends StatelessWidget {
  const GdsChatSendingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GdsIcon.galleryFill.build(
      width: GdsIconSize.v16,
      height: GdsIconSize.v16,
      color: context.gdsColors.icon.graySubtler,
    );
  }
}
