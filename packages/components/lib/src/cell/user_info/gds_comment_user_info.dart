part of '../gds_user_info.dart';

class GdsCommentUserInfo extends GdsUserInfo {
  final String nickName;
  final VoidCallback? onNameTap;
  final bool showTag;
  final bool showTime;
  final String? timeText;

  const GdsCommentUserInfo({
    super.key,
    required this.nickName,
    this.onNameTap,
    required this.showTag,
    required this.showTime,
    this.timeText,
  }) : assert(!showTime || timeText != null, 'timeText must not be null when showTime is true'),
       assert(showTime || timeText == null, 'timeText must be null when showTime is false');

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      children: [
        Flexible(
          child: GdsGesture(
            onTap: onNameTap,
            child: Text(
              nickName,
              style: GdsTypography.label5.copyWith(color: colors.text.grayBold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (showTag) ...[
          const SizedBox(width: GdsSpacing.spacing4),
          const GdsChip.medium(
            text: '작성자',
            variant: GdsChipVariant.primary,
          ),
        ],
        if (showTime && timeText != null) ...[
          const SizedBox(width: GdsSpacing.spacing8),
          Text(
            timeText!,
            style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
          ),
        ],
      ],
    );
  }
}
