import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=11138-188022&t=2EoK5AHjHgOYr0lR-4
class GdsThumbnail extends StatelessWidget {
  const new({
    super.key,
    required this.ratio,
    this.radius,
    this.border,
    this.provider,
    this.resolver,
    this.placeholder,
    this.width,
    this.height,
    this.cacheKey,
    this.fit = .cover,
  });

  final GdsThumbnailRatio ratio;
  final GdsRadius? radius;
  final GdsBorder? border;
  final ImageProvider? provider;
  final ImageProviderResolver? resolver;
  final ImageProvider? placeholder;
  final double? width;
  final double? height;
  final String? cacheKey;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return GdsContainer(
      width: width,
      height: height,
      radius: radius,
      border: border,
      clip: true,
      child: AspectRatio(
        aspectRatio: ratio.value,
        child: GdsImage(
          provider: provider,
          resolver: resolver,
          placeholder: placeholder,
          cacheKey: cacheKey,
          fit: fit,
        ),
      ),
    );
  }
}
