part of '../gds_icon.dart';

/// Grimity Design System 아이콘
///
/// SVG 아이콘을 위젯으로 빌드하는 enum.
///
/// ## 사용 예시
/// ```dart
/// // 기본 사용 (24x24)
/// GdsIcon.heartFill.build()
///
/// // 색상 지정
/// GdsIcon.heartFill.build(color: Colors.red)
///
/// // 사이즈 지정
/// GdsIcon.heartFill.build(
///   width: GdsIconSize.v16,
///   height: GdsIconSize.v16,
/// )
/// ```
///
enum GdsIcon implements IconBuilder {
  /// normal
  blank(path: 'assets/vector/normal/blank.svg'),
  addCircleFill(path: 'assets/vector/normal/add_circle_fill.svg'),
  addCircleOutline(path: 'assets/vector/normal/add_circle_outline.svg'),
  addSquareFill(path: 'assets/vector/normal/add_square_fill.svg'),
  addSquareOutline(path: 'assets/vector/normal/add_square_outline.svg'),
  arrowToDownLeft(path: 'assets/vector/normal/arrow_to_down_left.svg'),
  arrowToDownRight(path: 'assets/vector/normal/arrow_to_down_right.svg'),
  arrowToTopLeft(path: 'assets/vector/normal/arrow_to_top_left.svg'),
  arrowToTopRight(path: 'assets/vector/normal/arrow_to_top_right.svg'),
  bellFill(path: 'assets/vector/normal/bell_fill.svg'),
  bellOutline(path: 'assets/vector/normal/bell_outline.svg'),
  bold(path: 'assets/vector/normal/bold.svg'),
  bookmarkFill(path: 'assets/vector/normal/bookmark_fill.svg'),
  bookmarkOutline(path: 'assets/vector/normal/bookmark_outline.svg'),
  cameraFill(path: 'assets/vector/normal/camera_fill.svg'),
  cameraOutline(path: 'assets/vector/normal/camera_outline.svg'),
  chatRound(path: 'assets/vector/normal/chat_round.svg'),
  checkCircleFill(path: 'assets/vector/normal/check_circle_fill.svg'),
  checkCircleOutline(path: 'assets/vector/normal/check_circle_outline.svg'),
  checkSquareFill(path: 'assets/vector/normal/check_square_fill.svg'),
  checkSquareOutline(path: 'assets/vector/normal/check_square_outline.svg'),
  check(path: 'assets/vector/normal/check.svg'),
  chevronDoubleLeftThick(
    path: 'assets/vector/normal/chevron_double_left_thick.svg',
  ),
  chevronDoubleLeft(path: 'assets/vector/normal/chevron_double_left.svg'),
  chevronDoubleRightThick(
    path: 'assets/vector/normal/chevron_double_right_thick.svg',
  ),
  chevronDoubleRight(path: 'assets/vector/normal/chevron_double_right.svg'),
  chevronDownThick(path: 'assets/vector/normal/chevron_down_thick.svg'),
  chevronDown(path: 'assets/vector/normal/chevron_down.svg'),
  chevronLeftThick(path: 'assets/vector/normal/chevron_left_thick.svg'),
  chevronLeftTightThick(
    path: 'assets/vector/normal/chevron_left_tight_thick.svg',
  ),
  chevronLeftTight(path: 'assets/vector/normal/chevron_left_tight.svg'),
  chevronLeft(path: 'assets/vector/normal/chevron_left.svg'),
  chevronRightThick(path: 'assets/vector/normal/chevron_right_thick.svg'),
  chevronRightTightThick(
    path: 'assets/vector/normal/chevron_right_tight_thick.svg',
  ),
  chevronRightTight(path: 'assets/vector/normal/chevron_right_tight.svg'),
  chevronRight(path: 'assets/vector/normal/chevron_right.svg'),
  chevronUpThick(path: 'assets/vector/normal/chevron_up_thick.svg'),
  chevronUp(path: 'assets/vector/normal/chevron_up.svg'),
  closeCircleFill(path: 'assets/vector/normal/close_circle_fill.svg'),
  closeCircleOutline(path: 'assets/vector/normal/close_circle_outline.svg'),
  closeSquareFill(path: 'assets/vector/normal/close_square_fill.svg'),
  closeSquareOutline(path: 'assets/vector/normal/close_square_outline.svg'),
  dangerCircleFill(path: 'assets/vector/normal/danger_circle_fill.svg'),
  dangerCircleOutline(path: 'assets/vector/normal/danger_circle_outline.svg'),
  dangerTriangleFill(path: 'assets/vector/normal/danger_triangle_fill.svg'),
  dangerTriangleOutline(
    path: 'assets/vector/normal/danger_triangle_outline.svg',
  ),
  dislikeFill(path: 'assets/vector/normal/dislike_fill.svg'),
  dislikeOutline(path: 'assets/vector/normal/dislike_outline.svg'),
  dotMenuHorizontal(path: 'assets/vector/normal/dot_menu_horizontal.svg'),
  dotMenuVertical(path: 'assets/vector/normal/dot_menu_vertical.svg'),
  download(path: 'assets/vector/normal/download.svg'),
  eyeOff(path: 'assets/vector/normal/eye_off.svg'),
  eyeOn(path: 'assets/vector/normal/eye_on.svg'),
  folderEdit(path: 'assets/vector/normal/folder_edit.svg'),
  fontBg(path: 'assets/vector/normal/font_bg.svg'),
  fontColor(path: 'assets/vector/normal/font_color.svg'),
  forward2(path: 'assets/vector/normal/forward_2.svg'),
  forward(path: 'assets/vector/normal/forward.svg'),
  galleryEdit(path: 'assets/vector/normal/gallery_edit.svg'),
  galleryFill(path: 'assets/vector/normal/gallery_fill.svg'),
  galleryOutline(path: 'assets/vector/normal/gallery_outline.svg'),
  galleryWideFill(path: 'assets/vector/normal/gallery_wide_fill.svg'),
  galleryWideOutline(path: 'assets/vector/normal/gallery_wide_outline.svg'),
  hamburgerThick(path: 'assets/vector/normal/hamburger_thick.svg'),
  hamburger(path: 'assets/vector/normal/hamburger.svg'),
  head(path: 'assets/vector/normal/head.svg'),
  heartFill(path: 'assets/vector/normal/heart_fill.svg'),
  heartOutline(path: 'assets/vector/normal/heart_outline.svg'),
  signOut(path: 'assets/vector/normal/sign_out.svg'),
  inbox(path: 'assets/vector/normal/inbox.svg'),
  infoCircleFill(path: 'assets/vector/normal/info_circle_fill.svg'),
  infoCircleOutline(path: 'assets/vector/normal/info_circle_outline.svg'),
  italic(path: 'assets/vector/normal/italic.svg'),
  keyboardHide(path: 'assets/vector/normal/keyboard_hide.svg'),
  keyboardShow(path: 'assets/vector/normal/keyboard_show.svg'),
  likeFill(path: 'assets/vector/normal/like_fill.svg'),
  likeOutline(path: 'assets/vector/normal/like_outline.svg'),
  link(path: 'assets/vector/normal/link.svg'),
  magnifierFill(path: 'assets/vector/normal/magnifier_fill.svg'),
  magnifierOutline(path: 'assets/vector/normal/magnifier_outline.svg'),
  minusCircleFill(path: 'assets/vector/normal/minus_circle_fill.svg'),
  minusCircleOutline(path: 'assets/vector/normal/minus_circle_outline.svg'),
  minusThick(path: 'assets/vector/normal/minus_thick.svg'),
  minus(path: 'assets/vector/normal/minus.svg'),
  signIn(path: 'assets/vector/normal/sign_in.svg'),
  penFill(path: 'assets/vector/normal/pen_fill.svg'),
  penOutline(path: 'assets/vector/normal/pen_outline.svg'),
  pen2Fill(path: 'assets/vector/normal/pen2_fill.svg'),
  pen2Outline(path: 'assets/vector/normal/pen2_outline.svg'),
  personFill(path: 'assets/vector/normal/person_fill.svg'),
  personOutline(path: 'assets/vector/normal/person_outline.svg'),
  plusThick(path: 'assets/vector/normal/plus_thick.svg'),
  plus(path: 'assets/vector/normal/plus.svg'),
  questionCircleFill(path: 'assets/vector/normal/question_circle_fill.svg'),
  questionCircleOutline(
    path: 'assets/vector/normal/question_circle_outline.svg',
  ),
  redo(path: 'assets/vector/normal/redo.svg'),
  reply2(path: 'assets/vector/normal/reply_2.svg'),
  reply(path: 'assets/vector/normal/reply.svg'),
  settings(path: 'assets/vector/normal/settings.svg'),
  share(path: 'assets/vector/normal/share.svg'),
  sirenFill(path: 'assets/vector/normal/siren_fill.svg'),
  sirenOutline(path: 'assets/vector/normal/siren_outline.svg'),
  sortHorizontal(path: 'assets/vector/normal/sort_horizontal.svg'),
  strikeout(path: 'assets/vector/normal/strikeout.svg'),
  trash(path: 'assets/vector/normal/trash.svg'),
  underline(path: 'assets/vector/normal/underline.svg'),
  undo(path: 'assets/vector/normal/undo.svg'),
  xMarkThick(path: 'assets/vector/normal/x_mark_thick.svg'),
  xMark(path: 'assets/vector/normal/x_mark.svg'),
  replyComment(path: 'assets/vector/normal/reply_comment.svg'),
  pallete(path: 'assets/vector/normal/pallete.svg'),

  /// brand
  apple(path: 'assets/vector/brand/apple.svg'),
  email(path: 'assets/vector/brand/email.svg'),
  facebookBg(path: 'assets/vector/brand/facebook_bg.svg'),
  facebook(path: 'assets/vector/brand/facebook.svg'),
  google(path: 'assets/vector/brand/google.svg'),
  instagramBg(path: 'assets/vector/brand/instagram_bg.svg'),
  instagram(path: 'assets/vector/brand/instagram.svg'),
  kakaotalkBg(path: 'assets/vector/brand/kakaotalk_bg.svg'),
  kakaotalkSimple(path: 'assets/vector/brand/kakaotalk_simple.svg'),
  kakaotalk(path: 'assets/vector/brand/kakaotalk.svg'),
  pixivBg(path: 'assets/vector/brand/pixiv_bg.svg'),
  pixiv(path: 'assets/vector/brand/pixiv.svg'),
  threadBg(path: 'assets/vector/brand/thread_bg.svg'),
  thread(path: 'assets/vector/brand/thread.svg'),
  xBg(path: 'assets/vector/brand/x_bg.svg'),
  x(path: 'assets/vector/brand/x.svg'),
  youtubeBg(path: 'assets/vector/brand/youtube_bg.svg'),
  youtube(path: 'assets/vector/brand/youtube.svg'),

  /// logo
  faviconBlack(path: 'assets/vector/logo/favicon_black.svg'),
  faviconBlackBg(path: 'assets/vector/logo/favicon_black_bg.svg'),
  faviconWhite(path: 'assets/vector/logo/favicon_white.svg'),
  faviconWhiteBg(path: 'assets/vector/logo/favicon_white_bg.svg'),
  logo(path: 'assets/vector/logo/logo.svg'),

  /// navigation
  board(path: 'assets/vector/navigation/board.svg'),
  following(path: 'assets/vector/navigation/following.svg'),
  home(path: 'assets/vector/navigation/home.svg'),
  message(path: 'assets/vector/navigation/message.svg'),
  paint(path: 'assets/vector/navigation/paint.svg'),

  /// graphic
  rank1(path: 'assets/vector/graphic/rank1.svg'),
  rank2(path: 'assets/vector/graphic/rank2.svg'),
  rank3(path: 'assets/vector/graphic/rank3.svg'),
  rank4(path: 'assets/vector/graphic/rank4.svg'),

  /// illust_icon
  alarm(path: 'assets/vector/illust_icon/alarm.svg'),
  illust(path: 'assets/vector/illust_icon/illust.svg'),
  illustReply(path: 'assets/vector/illust_icon/reply.svg'),
  resultNull(path: 'assets/vector/illust_icon/result_null.svg'),
  success(path: 'assets/vector/illust_icon/success.svg'),
  uploadSuccess(path: 'assets/vector/illust_icon/upload_success.svg'),
  user(path: 'assets/vector/illust_icon/user.svg'),
  warning(path: 'assets/vector/illust_icon/warning.svg');

  const GdsIcon({required this.path});

  final String path;

  @override
  Widget build({Color? color, double? width, double? height}) {
    final iconWidth = width ?? GdsIconSize.defaultSize;
    final iconHeight = height ?? GdsIconSize.defaultSize;

    return SvgPicture.asset(
      path,
      package: 'gds_foundation',
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: iconWidth,
      height: iconHeight,
    );
  }
}
