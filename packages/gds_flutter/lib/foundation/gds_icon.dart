import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/id_color_mapper.dart';

/// 아이콘의 색상 및 테마 적용 방식을 나타내는 유형.
enum GdsIconType {
  /// 고정된 색상을 사용하는 아이콘.
  fixed,

  /// 테마에 따라 고정된 색상을 사용하는 아이콘.
  themed,

  /// 상황에 따라 지정된 시맨틱 색상을 사용하는 아이콘.
  semantic,
}

/// https://www.figma.com/design/P1ouNc7cOpjW3MDU3wYdvI/Grimity_Design-System?node-id=9257-209126&m=dev
enum GdsIcon {
  // Normal
  addCircle.semantic('normal/add_circle.svg'),
  addCircleFill.semantic('normal/add_circle_fill.svg'),
  addSquare.semantic('normal/add_square.svg'),
  addSquareFill.semantic('normal/add_square_fill.svg'),
  arrowToDownLeft.semantic('normal/arrow_to_down_left.svg'),
  arrowToDownRight.semantic('normal/arrow_to_down_right.svg'),
  arrowToTopLeft.semantic('normal/arrow_to_top_left.svg'),
  arrowToTopRight.semantic('normal/arrow_to_top_right.svg'),
  bell.semantic('normal/bell.svg'),
  bellFill.semantic('normal/bell_fill.svg'),
  blank.semantic('normal/blank.svg'),
  bold.semantic('normal/bold.svg'),
  bookmark.semantic('normal/bookmark.svg'),
  bookmarkFill.semantic('normal/bookmark_fill.svg'),
  calendar.semantic('normal/calendar.svg'),
  calendarMinimalistic.semantic('normal/calendar_minimalistic.svg'),
  camera.semantic('normal/camera.svg'),
  cameraFill.semantic('normal/camera_fill.svg'),
  chatRound.semantic('normal/chat_round.svg'),
  check.semantic('normal/check.svg'),
  checkCircle.semantic('normal/check_circle.svg'),
  checkCircleFill.semantic('normal/check_circle_fill.svg'),
  checkSquare.semantic('normal/check_square.svg'),
  checkSquareFill.semantic('normal/check_square_fill.svg'),
  chevronDoubleLeftThick.semantic('normal/chevron_double_left_thick.svg'),
  chevronDoubleLeft.semantic('normal/chevron_double_left.svg'),
  chevronDoubleRightThick.semantic('normal/chevron_double_right_thick.svg'),
  chevronDoubleRight.semantic('normal/chevron_double_right.svg'),
  chevronDownThick.semantic('normal/chevron_down_thick.svg'),
  chevronDown.semantic('normal/chevron_down.svg'),
  chevronLeftTight.semantic('normal/chevron_left_tight.svg'),
  chevronLeftTightThick.semantic('normal/chevron_left_tight_thick.svg'),
  chevronLeftThick.semantic('normal/chevron_left_thick.svg'),
  chevronLeft.semantic('normal/chevron_left.svg'),
  chevronRightTight.semantic('normal/chevron_right_tight.svg'),
  chevronRightTightThick.semantic('normal/chevron_right_tight_thick.svg'),
  chevronRightThick.semantic('normal/chevron_right_thick.svg'),
  chevronRight.semantic('normal/chevron_right.svg'),
  chevronUpThick.semantic('normal/chevron_up_thick.svg'),
  chevronUp.semantic('normal/chevron_up.svg'),
  closeCircle.semantic('normal/close_circle.svg'),
  closeCircleFill.semantic('normal/close_circle_fill.svg'),
  closeSquare.semantic('normal/close_square.svg'),
  closeSquareFill.semantic('normal/close_square_fill.svg'),
  dangerCircle.semantic('normal/danger_circle.svg'),
  dangerCircleFill.semantic('normal/danger_circle_fill.svg'),
  dangerTriangle.semantic('normal/danger_triangle.svg'),
  dangerTriangleFill.semantic('normal/danger_triangle_fill.svg'),
  dislike.semantic('normal/dislike.svg'),
  dislikeFill.semantic('normal/dislike_fill.svg'),
  document.semantic('normal/document.svg'),
  dotmenuHorizontal.semantic('normal/dotmenu_horizontal.svg'),
  dotmenuVertical.semantic('normal/dotmenu_vertical.svg'),
  down.semantic('normal/down.svg'),
  eye.semantic('normal/eye.svg'),
  eyeOff.semantic('normal/eye_off.svg'),
  folderEdit.semantic('normal/folder_edit.svg'),
  fontBg.themed('normal/font_bg.svg'),
  fontColor.themed('normal/font_color.svg'),
  forward.semantic('normal/forward.svg'),
  forward2.semantic('normal/forward2.svg'),
  gallery.semantic('normal/gallery.svg'),
  galleryEdit.semantic('normal/gallery_edit.svg'),
  galleryFill.semantic('normal/gallery_fill.svg'),
  galleryWide.semantic('normal/gallery_wide.svg'),
  galleryWideFill.semantic('normal/gallery_wide_fill.svg'),
  hamburger.semantic('normal/hamburger.svg'),
  hamburgerFill.semantic('normal/hamburger_fill.svg'),
  head.semantic('normal/head.svg'),
  heart.semantic('normal/heart.svg'),
  heartFill.semantic('normal/heart_fill.svg'),
  inIcon.semantic('normal/in.svg'),
  inbox.semantic('normal/inbox.svg'),
  infoCircle.semantic('normal/info_circle.svg'),
  infoCircleFill.semantic('normal/info_circle_fill.svg'),
  italic.semantic('normal/italic.svg'),
  keyboardDown.semantic('normal/keyboard_down.svg'),
  keyboardUp.semantic('normal/keyboard_up.svg'),
  like.semantic('normal/like.svg'),
  likeFill.semantic('normal/like_fill.svg'),
  link.semantic('normal/link.svg'),
  magnifier.semantic('normal/magnifier.svg'),
  magnifierFill.semantic('normal/magnifier_fill.svg'),
  minus.semantic('normal/minus.svg'),
  minusCircle.semantic('normal/minus_circle.svg'),
  minusCircleFill.semantic('normal/minus_circle_fill.svg'),
  minusThick.semantic('normal/minus_thick.svg'),
  out.semantic('normal/out.svg'),
  pallete.semantic('normal/pallete.svg'),
  pen.semantic('normal/pen.svg'),
  penFill.semantic('normal/pen_fill.svg'),
  pen2.semantic('normal/pen2.svg'),
  pen2Fill.semantic('normal/pen2_fill.svg'),
  person.semantic('normal/person.svg'),
  personFill.semantic('normal/person_fill.svg'),
  pin.semantic('normal/pin.svg'),
  plus.semantic('normal/plus.svg'),
  plusThick.semantic('normal/plus_thick.svg'),
  questionCircle.semantic('normal/question_circle.svg'),
  questionCircleFill.semantic('normal/question_circle_fill.svg'),
  redo.semantic('normal/redo.svg'),
  reply.semantic('normal/reply.svg'),
  reply2.semantic('normal/reply2.svg'),
  settings.semantic('normal/settings.svg'),
  share.semantic('normal/share.svg'),
  sirenRounded.semantic('normal/siren_rounded.svg'),
  sirenRoundedFill.semantic('normal/siren_rounded_fill.svg'),
  sortHorizontal.semantic('normal/sort_horizontal.svg'),
  strikeout.semantic('normal/strikeout.svg'),
  trashBinTrash.semantic('normal/trash_bin_trash.svg'),
  underline.semantic('normal/underline.svg'),
  undo.semantic('normal/undo.svg'),
  x.semantic('normal/x.svg'),
  xThick.semantic('normal/x_thick.svg'),

  // Brand
  logoApple.themed('brand/logo_apple.svg'),
  logoEmail.fixed('brand/logo_email.svg'),
  logoFacebookBg.fixed('brand/logo_facebook_bg.svg'),
  logoFacebook.fixed('brand/logo_facebook.svg'),
  logoGoogle.fixed('brand/logo_google.svg'),
  logoInstagramBg.fixed('brand/logo_instagram_bg.svg'),
  logoInstagram.fixed('brand/logo_instagram.svg'),
  logoKakaoBg.fixed('brand/logo_kakao_bg.svg'),
  logoKakaoSimple.themed('brand/logo_kakao_simple.svg'),
  logoKakao.fixed('brand/logo_kakao.svg'),
  logoPixivBg.fixed('brand/logo_pixiv_bg.svg'),
  logoPixiv.fixed('brand/logo_pixiv.svg'),
  logoThreadBg.themed('brand/logo_thread_bg.svg'),
  logoThread.themed('brand/logo_thread.svg'),
  logoXBg.themed('brand/logo_x_bg.svg'),
  logoX.themed('brand/logo_x.svg'),
  logoYoutubeBg.fixed('brand/logo_youtube_bg.svg'),
  logoYoutube.fixed('brand/logo_youtube.svg'),

  // Logo
  logoFaviconBg.themed('logo/logo_favicon_bg.svg'),
  logoFaviconCircleBg.themed('logo/logo_favicon_circle_bg.svg'),
  logoFaviconInverse.themed('logo/logo_favicon_inverse.svg'),
  logoFavicon.themed('logo/logo_favicon.svg'),
  logo.themed('logo/logo.svg'),

  // Navigation
  board.semantic('navigation/board.svg'),
  following.semantic('navigation/following.svg'),
  home.semantic('navigation/home.svg'),
  navigationInbox.semantic('navigation/inbox.svg'),
  letterOpened.semantic('navigation/letter_opened.svg'),
  magicStick.semantic('navigation/magic_stick.svg'),
  message.semantic('navigation/message.svg'),
  paint.semantic('navigation/paint.svg'),

  // Graphic
  rank1.fixed('graphic/rank1.svg'),
  rank2.fixed('graphic/rank2.svg'),
  rank3.fixed('graphic/rank3.svg'),
  rank4.fixed('graphic/rank4.svg'),

  // Illust
  alarm.themed('illust/alarm.svg'),
  goodMost.fixed('illust/good_most.svg'),
  good.fixed('illust/good.svg'),
  illust.themed('illust/illust.svg'),
  loveMost.fixed('illust/love_most.svg'),
  love.fixed('illust/love.svg'),
  illustReply.themed('illust/reply.svg'),
  resultNull.themed('illust/result_null.svg'),
  sadMost.fixed('illust/sad_most.svg'),
  sad.fixed('illust/sad.svg'),
  success.themed('illust/success.svg'),
  uploadSuccess.themed('illust/upload_success.svg'),
  user.themed('illust/user.svg'),
  warning.themed('illust/warning.svg');

  const new fixed(this.path) : type = .fixed;
  const new themed(this.path) : type = .themed;
  const new semantic(this.path) : type = .semantic;

  /// 아이콘의 유형.
  final GdsIconType type;

  /// 아이콘에 대한 벡터 이미지 파일 경로.
  final String path;

  /// 에셋 로더에서 사용하는 상대 경로를 반환합니다.
  String get assetName => 'packages/gds_flutter/assets/vectors/icon/$path';

  /// 주어진 크기와 색상이 적용된 아이콘 위젯을 반환합니다.
  Widget build({
    required double size,
    GdsColor? color,
    GdsColorMap? colorMap,
    GdsAnimation animation = .normal,
  }) {
    assert(type != .fixed || color == null, '색상을 지정할 수 없는 아이콘입니다.');
    assert(type != .themed || color == null, '색상을 지정할 수 없는 아이콘입니다.');
    assert(type != .semantic || color != null, '색상을 지정해야 하는 아이콘입니다.');

    return FutureBuilder(
      future: rootBundle.loadString(assetName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          assert(false, '\'$this\'에 대한 에러: ${snapshot.error}');

          return Placeholder(
            fallbackWidth: size,
            fallbackHeight: size,
          );
        }

        if (!snapshot.hasData) {
          return SizedBox(width: size, height: size);
        }

        String content = snapshot.data!;

        // 테마 아이콘의 `@colorName`와 같은 토큰을 실질적인 색상 코드로 치환.
        if (type == .themed) {
          content = content.replaceAllMapped(RegExp(r'@([a-zA-Z]+)'), (match) {
            final tagName = match.group(1)!; // 예: bgPrimary
            final color = GdsColor.fromName(tagName);
            return color.of(context).toHex();
          });
        }

        // 주어진 색상 맵을 현재 테마에 기반한 실제 색상 값으로 변환.
        final resolvedColorMap = colorMap?.map((key, value) => .new(key, value.of(context)));

        // 주어진 색상으로 SVG를 렌더링하도록 합니다.
        Widget build(Color? color) {
          return SvgPicture.string(
            content,
            renderingStrategy: .raster,
            colorFilter: color != null ? ColorFilter.mode(color, .srcIn) : null,
            colorMapper: resolvedColorMap != null ? IdColorMapper(resolvedColorMap) : null,
            width: size,
            height: size,
          );
        }

        // 색상이 지정된 경우에만 전환 애니메이션 적용.
        if (color != null) {
          final rawColor = color.of(context);

          return TweenAnimationBuilder(
            duration: animation.duration,
            curve: animation.curve,
            tween: ColorTween(
              begin: rawColor,
              end: rawColor,
            ),
            builder: (context, value, _) => build(value),
          );
        }

        return build(null);
      },
    );
  }

  @override
  String toString() => path;
}
