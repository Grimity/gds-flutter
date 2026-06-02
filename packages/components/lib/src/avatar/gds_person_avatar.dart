import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsAvatarSize {
  xxl,
  xl,
  lg,
  ml,
  md,
  sm,
  xs;

  double get value => switch (this) {
    GdsAvatarSize.xxl => 100,
    GdsAvatarSize.xl => 80,
    GdsAvatarSize.lg => 64,
    GdsAvatarSize.ml => 48,
    GdsAvatarSize.md => 40,
    GdsAvatarSize.sm => 32,
    GdsAvatarSize.xs => 24,
  };

  // AvatarCacheSize
  int cacheSize(BuildContext context) {
    return (value * MediaQuery.of(context).devicePixelRatio).round();
  }
}

class GdsPersonAvatar extends StatelessWidget {
  const GdsPersonAvatar({
    super.key,
    this.size = GdsAvatarSize.md,
    this.imageUrl,
    this.placeholder,
    this.errorWidget,
  });

  final GdsAvatarSize size;
  final String? imageUrl;
  final BoxFit fit = BoxFit.cover;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  bool get _hasImage => (imageUrl ?? '').trim().isNotEmpty;

  bool _isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _borderColor(BuildContext context) {
    return _isDarkTheme(context) ? GdsAtomicColorGray.v80 : context.gdsColors.border.graySubtler;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor(context), width: 1),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: _hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size.value,
                height: size.value,
                memCacheWidth: size.cacheSize(context),
                memCacheHeight: size.cacheSize(context),
                fit: fit,
                placeholder: placeholder ?? (context, _) => defaultPersonAvatar(context),
                errorWidget: errorWidget ?? (context, _, _) => defaultErrorWidget(context),
                fadeInDuration: Duration(milliseconds: 300),
                fadeInCurve: Curves.easeInOut,
                fadeOutDuration: Duration(milliseconds: 300),
                fadeOutCurve: Curves.easeInOut,
                placeholderFadeInDuration: Duration(milliseconds: 300),
              )
            : defaultPersonAvatar(context),
      ),
    );
  }

  /// [GdsPersonAvatar]에 대한 [placeholder]의 기본 빌더입니다.
  Widget defaultPersonAvatar(BuildContext context) {
    final asset = _isDarkTheme(context)
        ? GdsImage.avatarPlaceholderDark.build(width: size.value, height: size.value, fit: fit)
        : GdsImage.avatarPlaceholderLight.build(width: size.value, height: size.value, fit: fit);

    return SizedBox(width: size.value, height: size.value, child: asset);
  }

  /// [GdsPersonAvatar]에 대한 [errorWidget]의 기본 빌더입니다.
  Widget defaultErrorWidget(BuildContext context) {
    return defaultPersonAvatar(context);
  }
}
