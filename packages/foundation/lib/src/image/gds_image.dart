part of '../gds_image.dart';

/// Grimity Design System 이미지
///
/// Png 이미지를 위젯으로 빌드하는 enum.
///
/// ## 사용 예시
/// ```dart
/// GdsImage.avatarPlaceholderDark.build()
/// ```
///
enum GdsImage implements ImageBuilder {
  avatarPlaceholderDark(path: 'assets/images/image/avatar_placeholder_dark.png'),
  avatarPlaceholderLight(path: 'assets/images/image/avatar_placeholder_light.png'),
  thumbnailPlaceholderDark(path: 'assets/images/image/thumbnail_placeholder_dark.png'),
  thumbnailPlaceholderLight(path: 'assets/images/image/thumbnail_placeholder_light.png');

  const GdsImage({required this.path});

  final String path;

  @override
  Widget build({double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      path,
      package: 'gds_foundation',
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
    );
  }
}
