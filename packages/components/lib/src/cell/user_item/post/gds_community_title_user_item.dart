part of '../../gds_user_item.dart';

class GdsCommunityTitleUserItem extends GdsUserItem {
  final String titleText;
  final bool showTag;
  final GdsChip? chip;
  final int commentCount;
  final String contentText;
  final GdsUserInfo userInfo;

  const GdsCommunityTitleUserItem({
    super.key,
    required this.titleText,
    required this.showTag,
    this.chip,
    required this.commentCount,
    required this.contentText,
    required this.userInfo,
  }) : assert(
         !showTag || chip != null,
         'chip must not be null when showTag is true',
       );

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: GdsSpacing.spacing8,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: GdsSpacing.spacing4,
                children: [
                  Row(
                    spacing: GdsSpacing.spacing4,
                    children: [
                      if (showTag && chip != null) chip!,
                      Expanded(
                        child: Row(
                          spacing: GdsSpacing.spacing4,
                          children: [
                            Flexible(
                              child: Text(
                                titleText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GdsTypography.label1.copyWith(color: colors.text.grayBold),
                              ),
                            ),
                            GdsNumberPushBadge.outline(count: commentCount),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    contentText,
                    style: GdsTypography.body2R.copyWith(color: colors.text.grayBold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              userInfo,
            ],
          ),
        ),
        GdsDivider.secondary(),
      ],
    );
  }
}
