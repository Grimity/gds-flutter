part of '../../gds_user_item.dart';

class GdsTitleUserItem extends GdsUserItem {
  final String titleText;
  final bool showTag;
  final GdsChip? chip;
  final GdsUserInfo userInfo;

  const GdsTitleUserItem({
    super.key,
    required this.titleText,
    required this.showTag,
    this.chip,
    required this.userInfo,
  }) : assert(!showTag || chip != null, 'chip must not be null when showTag is true');

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: GdsSpacing.spacing12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: GdsSpacing.spacing8,
            children: [
              Row(
                spacing: GdsSpacing.spacing4,
                children: [
                  if (showTag && chip != null) chip!,
                  Expanded(
                    child: Text(
                      titleText,
                      style: GdsTypography.label1.copyWith(color: colors.text.grayBold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              userInfo,
            ],
          ),
        ),
        const GdsDivider.secondary(),
      ],
    );
  }
}
