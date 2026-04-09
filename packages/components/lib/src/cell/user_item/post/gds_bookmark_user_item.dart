part of '../../gds_user_item.dart';

class GdsBookmarkUserItem extends GdsUserItem {
  final String titleText;
  final bool showImageIcon;
  final bool showTag;
  final GdsChip? chip;
  final int commentCount;
  final String contentText;
  final GdsUserInfo userInfo;
  final bool showBookmark;
  final GdsBookmark? bookmark;

  const GdsBookmarkUserItem({
    super.key,
    required this.titleText,
    required this.showImageIcon,
    required this.showTag,
    this.chip,
    required this.commentCount,
    required this.contentText,
    required this.userInfo,
    required this.showBookmark,
    this.bookmark,
  }) : assert(!showTag || chip != null, 'chip must not be null when showTag is true'),
       assert(!showBookmark || bookmark != null, 'bookmark must not be null when showBookmark is true');

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: GdsSpacing.spacing16,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: GdsSpacing.spacing8,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: GdsSpacing.spacing4,
                      children: [
                        Row(
                          spacing: GdsSpacing.spacing6,
                          children: [
                            if (showTag && chip != null) chip!,
                            if (showImageIcon)
                              GdsIcon.galleryFill.build(
                                width: GdsIconSize.v16,
                                height: GdsIconSize.v16,
                                color: colors.icon.graySubtle,
                              ),
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    userInfo,
                  ],
                ),
              ),
              if (showBookmark && bookmark != null) bookmark!,
            ],
          ),
        ),
        GdsDivider.secondary(),
      ],
    );
  }
}
