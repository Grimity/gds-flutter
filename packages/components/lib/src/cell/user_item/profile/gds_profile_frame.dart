part of '../../gds_user_item.dart';

class _GdsProfileUserItemFrame extends StatelessWidget {
  const _GdsProfileUserItemFrame({
    required this.personAvatar,
    required this.mainContent,
    this.trailing,
    this.onTap,
  });

  final Widget personAvatar;
  final Widget mainContent;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GdsSpacing.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: GdsSpacing.spacing12,
        children: [
          GdsGesture(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                personAvatar,
                const SizedBox(width: GdsSpacing.spacing8),
                Flexible(child: mainContent),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _GdsProfileMainContent extends StatelessWidget {
  const _GdsProfileMainContent({
    required this.nickName,
    this.secondaryContent,
  });

  final String nickName;
  final Widget? secondaryContent;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nickName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GdsTypography.label3.copyWith(color: colors.text.grayBold),
        ),
        if (secondaryContent != null) ...[
          const SizedBox(height: GdsSpacing.spacing2),
          secondaryContent!,
        ],
      ],
    );
  }
}

Widget? _buildDualActions(
  Widget? primaryActionButton,
  Widget? secondaryActionButton, {
  double spacing = GdsSpacing.spacing8,
}) {
  if (primaryActionButton == null && secondaryActionButton == null) {
    return null;
  }

  return Row(
    spacing: spacing,
    children: [
      primaryActionButton,
      secondaryActionButton,
    ].whereType<Widget>().toList(),
  );
}
