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
  thumbnailPlaceholderLight(path: 'assets/images/image/thumbnail_placeholder_light.png'),

  // app_login/* 폴더 내 이미지들은 앱 로그인 마이크로 인터랙션에서 사용되는 이미지입니다.
  appLogin1_1(path: 'assets/images/app_login/1-1.png'),
  appLogin1_2(path: 'assets/images/app_login/1-2.png'),
  appLogin1_3(path: 'assets/images/app_login/1-3.png'),
  appLogin1_4(path: 'assets/images/app_login/1-4.png'),
  appLogin1_5(path: 'assets/images/app_login/1-5.png'),
  appLogin2_1(path: 'assets/images/app_login/2-1.png'),
  appLogin2_2(path: 'assets/images/app_login/2-2.png'),
  appLogin2_3(path: 'assets/images/app_login/2-3.png'),
  appLogin2_4(path: 'assets/images/app_login/2-4.png'),
  appLogin2_5(path: 'assets/images/app_login/2-5.png'),
  appLogin3_1(path: 'assets/images/app_login/3-1.png'),
  appLogin3_2(path: 'assets/images/app_login/3-2.png'),
  appLogin3_3(path: 'assets/images/app_login/3-3.png'),
  appLogin3_4(path: 'assets/images/app_login/3-4.png'),
  appLogin3_5(path: 'assets/images/app_login/3-5.png');

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
