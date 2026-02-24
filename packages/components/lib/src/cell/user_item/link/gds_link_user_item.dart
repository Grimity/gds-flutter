part of '../../gds_user_item.dart';

class GdsLinkUserItem extends GdsUserItem {
  final GdsIcon icon;
  final String siteText;
  final String linkText;

  const GdsLinkUserItem({
    super.key,
    required this.icon,
    required this.siteText,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: GdsSpacing.spacing8),
      child: Row(
        spacing: GdsSpacing.spacing12,
        children: [
          icon.build(
            width: GdsIconSize.v32,
            height: GdsIconSize.v32,
          ),
          Expanded(
            child: Column(
              spacing: GdsSpacing.spacing2,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  siteText,
                  style: GdsTypography.label3.copyWith(color: colors.text.grayBold),
                ),
                Text(
                  linkText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GdsTypography.label6.copyWith(color: colors.text.graySubtle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
