part of '../gds_user_info.dart';

class GdsDefaultUserInfo extends StatelessWidget {
  final String nickName;
  final VoidCallback? onNameTap;
  final bool showHeart;
  final int? heartCount;
  final bool showView;
  final int? viewCount;
  final bool showTime;
  final String? timeText;

  const GdsDefaultUserInfo({
    super.key,
    required this.nickName,
    this.onNameTap,
    required this.showHeart,
    this.heartCount,
    required this.showView,
    this.viewCount,
    required this.showTime,
    this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final dotSeparator = const DotSeparator();

    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: onNameTap,
            child: Text(
              nickName,
              style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (showHeart && heartCount != null) ...[
          dotSeparator,
          Row(
            children: [
              GdsIcon.heartOutline.build(
                width: GdsIconSize.v16,
                height: GdsIconSize.v16,
                color: colors.icon.graySubtle,
              ),
              const SizedBox(width: GdsSpacing.spacing2),
              Text(
                '$heartCount',
                style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
              ),
            ],
          ),
        ],
        if (showView && viewCount != null) ...[
          dotSeparator,
          Row(
            children: [
              GdsIcon.eyeOn.build(
                width: GdsIconSize.v16,
                height: GdsIconSize.v16,
                color: colors.icon.graySubtle,
              ),
              const SizedBox(width: GdsSpacing.spacing2),
              Text(
                '$viewCount',
                style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
              ),
            ],
          ),
        ],
        if (showTime && timeText != null) ...[
          dotSeparator,
          Text(
            timeText!,
            style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
          ),
        ],
      ],
    );
  }
}
