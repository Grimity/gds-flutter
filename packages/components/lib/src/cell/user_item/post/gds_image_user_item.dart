part of '../../gds_user_item.dart';

class GdsImageUserItem extends GdsUserItem {
  final String titleText;
  final GdsThumbnail thumbnail;
  final GdsUserInfo userInfo;

  const GdsImageUserItem({
    super.key,
    required this.titleText,
    required this.thumbnail,
    required this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: GdsSpacing.spacing12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: GdsSpacing.spacing12,
            children: [
              thumbnail,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: GdsSpacing.spacing8,
                  children: [
                    Text(
                      titleText,
                      style: GdsTypography.label1.copyWith(color: colors.text.grayBold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    userInfo,
                  ],
                ),
              ),
            ],
          ),
        ),
        const GdsDivider.secondary(),
      ],
    );
  }
}
