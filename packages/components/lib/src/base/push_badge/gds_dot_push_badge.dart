part of '../gds_push_badge.dart';

enum GdsDotPushBadgeType {
  xSmall,
  small,
  medium;

  double get size => switch (this) {
    GdsDotPushBadgeType.xSmall => 4.0,
    GdsDotPushBadgeType.small => 6.0,
    GdsDotPushBadgeType.medium => 8.0,
  };
}

enum GdsDotPushBadgePosition {
  topRight,
  bottomRight,
  bottomLeft,
  topLeft;

  static const double _centerInset = 2;

  Positioned positioned({required double dimension, required Widget child}) {
    final offset = _centerInset - dimension / 2;
    return switch (this) {
      topRight => Positioned(top: offset, right: offset, child: child),
      bottomRight => Positioned(bottom: offset, right: offset, child: child),
      bottomLeft => Positioned(bottom: offset, left: offset, child: child),
      topLeft => Positioned(top: offset, left: offset, child: child),
    };
  }
}

class GdsDotPushBadge extends StatelessWidget {
  final Widget child;
  final GdsDotPushBadgeType type;
  final GdsDotPushBadgePosition position;

  const GdsDotPushBadge({
    super.key,
    required this.child,
    this.type = GdsDotPushBadgeType.small,
    this.position = GdsDotPushBadgePosition.topRight,
  });

  const GdsDotPushBadge.xSmall({
    super.key,
    required this.child,
    this.position = GdsDotPushBadgePosition.topRight,
  }) : type = GdsDotPushBadgeType.xSmall;

  const GdsDotPushBadge.small({
    super.key,
    required this.child,
    this.position = GdsDotPushBadgePosition.topRight,
  }) : type = GdsDotPushBadgeType.small;

  const GdsDotPushBadge.medium({
    super.key,
    required this.child,
    this.position = GdsDotPushBadgePosition.topRight,
  }) : type = GdsDotPushBadgeType.medium;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        position.positioned(
          dimension: type.size,
          child: SizedBox.square(
            dimension: type.size,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: context.gdsColors.status.notification,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
