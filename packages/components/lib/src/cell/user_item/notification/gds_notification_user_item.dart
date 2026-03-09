part of '../../gds_user_item.dart';

class GdsNotificationUserItem extends GdsUserItem {
  final String titleText;
  final String messageText;
  final String timeText;
  final VoidCallback? onTap;
  final GdsIconButton iconButton;

  const GdsNotificationUserItem({
    super.key,
    required this.titleText,
    required this.messageText,
    required this.timeText,
    this.onTap,
    required this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: GdsSpacing.spacing12,
        children: [
          Expanded(
            child: GdsGesture(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: GdsSpacing.spacing8,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: GdsSpacing.spacing2,
                    children: [
                      Text(
                        titleText,
                        style: GdsTypography.label5.copyWith(color: colors.text.primaryNormal),
                      ),
                      Text(
                        messageText,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GdsTypography.label4.copyWith(color: colors.text.grayBold),
                      ),
                    ],
                  ),
                  Text(
                    timeText,
                    style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
                  ),
                ],
              ),
            ),
          ),
          iconButton,
        ],
      ),
    );
  }
}
