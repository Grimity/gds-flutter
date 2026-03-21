import 'package:flutter/widgets.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsDividerType {
  brand,
  primary,
  secondary;

  Color color(GdsSemanticColor colors) => switch (this) {
    GdsDividerType.brand => colors.border.primaryNormal,
    GdsDividerType.primary => colors.border.graySubtle,
    GdsDividerType.secondary => colors.border.graySubtler,
  };

  BorderRadius? get borderRadius => switch (this) {
    GdsDividerType.brand => BorderRadius.circular(GdsRadius.full),
    _ => null,
  };
}

enum GdsDividerSize {
  normal,
  bold,
  vertical;

  double get thickness => switch (this) {
    GdsDividerSize.normal => 1,
    GdsDividerSize.bold => 12,
    GdsDividerSize.vertical => 1,
  };
}

class GdsDivider extends StatelessWidget {
  final GdsDividerType type;
  final GdsDividerSize size;
  final double? extent;

  const GdsDivider({
    super.key,
    required this.type,
    this.size = GdsDividerSize.normal,
    this.extent,
  }) : assert(
         type != GdsDividerType.brand || size == GdsDividerSize.normal,
         'brand 타입은 noraml 사이즈만 지원합니다.',
       );

  const GdsDivider.brand({super.key, this.extent}) : type = GdsDividerType.brand, size = GdsDividerSize.normal;

  const GdsDivider.primary({super.key, this.extent, this.size = GdsDividerSize.normal}) : type = GdsDividerType.primary;

  const GdsDivider.secondary({super.key, this.extent, this.size = GdsDividerSize.normal}) : type = GdsDividerType.secondary;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final color = type.color(colors);

    if (size == GdsDividerSize.vertical) {
      return SizedBox(
        width: size.thickness,
        height: extent ?? double.infinity,
        child: DecoratedBox(decoration: BoxDecoration(color: color)),
      );
    }

    return SizedBox(
      width: extent ?? double.infinity,
      height: size.thickness,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: type.borderRadius,
        ),
      ),
    );
  }
}
