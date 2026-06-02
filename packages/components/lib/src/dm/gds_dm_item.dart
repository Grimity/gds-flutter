import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsDmItem extends StatelessWidget {
  const GdsDmItem({
    super.key,
    required this.nickname,
    required this.messageText,
    required this.timeText,
    required this.avatarImageUrl,
    this.isActive = false,
    this.showCheckbox = false,
    this.isChecked = false,
    this.onCheckboxTap,
    this.unreadCount,
    this.onTap,
  });

  final String nickname;
  final String messageText;
  final String timeText;
  final bool isActive;
  final bool showCheckbox;
  final bool isChecked;
  final VoidCallback? onCheckboxTap;
  final String avatarImageUrl;
  final int? unreadCount;
  final VoidCallback? onTap;

  bool get _showsUnreadBadge => (unreadCount ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: GdsSpacing.spacing12),
      child: Row(
        spacing: GdsSpacing.spacing12,
        children: [
          if (showCheckbox)
            GdsCheckbox(
              isChecked: isChecked,
              enabled: onCheckboxTap != null,
              onTap: onCheckboxTap ?? () {},
            ),
          Expanded(
            child: Row(
              spacing: GdsSpacing.spacing12,
              children: [
                GdsPersonAvatar(size: GdsAvatarSize.md, imageUrl: avatarImageUrl),
                Expanded(
                  child: _UserDetails(nickname: nickname, messageText: messageText, timeText: timeText),
                ),
              ],
            ),
          ),
          if (_showsUnreadBadge) GdsNumberPushBadge.solid(count: unreadCount!),
        ],
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(color: isActive ? colors.surface.graySubtler : null),
      child: onTap == null ? row : GdsGesture(onTap: onTap, child: row),
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    required this.nickname,
    required this.messageText,
    required this.timeText,
  });

  final String nickname;
  final String messageText;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: GdsSpacing.spacing4,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                nickname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GdsTypography.label5.copyWith(color: colors.text.grayNormal),
              ),
            ),
            const SizedBox(width: GdsSpacing.spacing4),
            const GdsEllipse(),
            const SizedBox(width: GdsSpacing.spacing4),
            Text(
              timeText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GdsTypography.label6.copyWith(color: colors.text.grayNormal),
            ),
          ],
        ),
        Text(
          messageText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GdsTypography.body2R.copyWith(color: colors.text.grayBold),
        ),
      ],
    );
  }
}
