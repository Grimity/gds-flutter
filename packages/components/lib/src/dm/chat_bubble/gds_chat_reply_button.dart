part of '../gds_chat_bubble.dart';

class GdsChatReplyButton extends StatelessWidget {
  const GdsChatReplyButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GdsIconButton.outlined(
      icon: GdsIcon.forward2,
      onPressed: onPressed,
    );
  }
}
