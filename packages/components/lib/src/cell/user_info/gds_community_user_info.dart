part of '../gds_user_info.dart';

class GdsCommunityUserInfo extends StatelessWidget {
  final bool showChat;
  final int? chatCount;
  final bool showHeart;
  final int? heartCount;
  final bool showView;
  final int? viewCount;
  final bool showTime;
  final String? timeText;

  const GdsCommunityUserInfo({
    super.key,
    required this.showChat,
    this.chatCount,
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
    final children = <Widget>[
      if (showChat && chatCount != null) ...[
        Row(
          children: [
            GdsIcon.chatRound.build(
              width: GdsIconSize.v16,
              height: GdsIconSize.v16,
              color: colors.icon.graySubtle,
            ),
            const SizedBox(width: GdsSpacing.spacing2),
            Text(
              '$chatCount',
              style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
            ),
          ],
        ),
      ],

      if (showHeart && heartCount != null) ...[
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
        Text(
          timeText!,
          style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
        ),
      ],
    ];

    if (children.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const DotSeparator(),
          children[i],
        ],
      ],
    );
  }
}
