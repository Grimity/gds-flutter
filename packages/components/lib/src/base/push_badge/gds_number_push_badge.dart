part of '../gds_push_badge.dart';

enum GdsNumberPushBadgeType {
  solid,
  outline,
  text;

  Color backgroundColor(GdsSemanticColor colors) => switch (this) {
    solid => colors.status.notification,
    outline => colors.surface.base,
    text => colors.surface.base,
  };

  Color textColor(GdsSemanticColor colors) => switch (this) {
    solid => colors.text.inverse,
    outline => colors.status.notification,
    text => colors.text.grayBold,
  };

  Border? border(GdsSemanticColor colors) => switch (this) {
    outline => Border.all(color: colors.border.graySubtler),
    _ => null,
  };
}

class GdsNumberPushBadge extends StatelessWidget {
  final int count;
  final GdsNumberPushBadgeType type;

  const GdsNumberPushBadge({
    super.key,
    required this.count,
    this.type = GdsNumberPushBadgeType.outline,
  });

  const GdsNumberPushBadge.solid({super.key, required this.count}) : type = GdsNumberPushBadgeType.solid;

  const GdsNumberPushBadge.outline({super.key, required this.count}) : type = GdsNumberPushBadgeType.outline;

  const GdsNumberPushBadge.text({super.key, required this.count}) : type = GdsNumberPushBadgeType.text;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing6),
          decoration: BoxDecoration(
            color: type.backgroundColor(colors),
            borderRadius: BorderRadius.circular(GdsRadius.lg),
            border: type.border(colors),
          ),
          child: Text(
            '$count',
            style: GdsTypography.label5.copyWith(color: type.textColor(colors)),
          ),
        ),
      ],
    );
  }
}
