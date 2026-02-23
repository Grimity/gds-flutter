import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../widgetbook_components/widgetbook_components.dart';

@widgetbook.UseCase(
  name: 'default',
  type: GdsIcon,
  path: '[foundation]/',
)
Widget buildGdsIconUseCase(BuildContext context) {
  return WidgetbookPageLayout(
    title: 'Icon',
    description: 'SVG 기반 아이콘입니다. GdsIcon enum을 통해 build() 메서드로 사용합니다.',
    children: [
      _buildPlaygroundSection(context),
      _buildDemonstrationSection(context),
    ],
  );
}

Widget _buildPlaygroundSection(BuildContext context) {
  final icon = context.knobs.object.dropdown<GdsIcon>(
    label: 'icon',
    options: GdsIcon.values,
    labelBuilder: (i) => i.name,
  );

  final size = context.knobs.object.dropdown<double>(
    label: 'size',
    options: [GdsIconSize.v12, GdsIconSize.v16, GdsIconSize.v20, GdsIconSize.v24, GdsIconSize.v32],
    initialOption: GdsIconSize.v24,
    labelBuilder: (s) => '${s.toInt()}px',
  );

  final useColor = context.knobs.boolean(label: 'custom color', initialValue: false);
  final color = useColor ? context.gdsColors.text.primaryNormal : null;

  return WidgetbookPlayground(
    info: [
      'icon: ${icon.name}',
      'size: ${size.toInt()}px',
      if (useColor) 'color: primaryNormal',
    ],
    child: icon.build(width: size, height: size, color: color),
  );
}

Widget _buildDemonstrationSection(BuildContext context) {
  final iconColor = context.gdsColors.icon.grayBold;

  return Column(
    spacing: 32,
    children: [
      _buildIconGrid('Normal', _normalIcons, iconColor),
      _buildIconGrid('Brand', _brandIcons, null),
      _buildIconGrid('Logo', _logoIcons, null),
      _buildIconGrid('Navigation', _navigationIcons, iconColor),
      _buildIconGrid('Graphic', _graphicIcons, null),
      _buildIconGrid('Illust Icon', _illustIcons, null),
    ],
  );
}

Widget _buildIconGrid(String title, List<GdsIcon> icons, Color? color) {
  return WidgetbookSection(
    title: title,
    children: [
      WidgetbookSubsection(
        title: 'icons',
        labels: ['${icons.length}개'],
        content: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final icon in icons)
              Tooltip(
                message: icon.name,
                child: SizedBox.square(
                  dimension: 48,
                  child: Center(child: icon.build(color: color)),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

const _normalIcons = [
  GdsIcon.addCircleFill,
  GdsIcon.addCircleOutline,
  GdsIcon.addSquareFill,
  GdsIcon.addSquareOutline,
  GdsIcon.arrowToDownLeft,
  GdsIcon.arrowToDownRight,
  GdsIcon.arrowToTopLeft,
  GdsIcon.arrowToTopRight,
  GdsIcon.bellFill,
  GdsIcon.bellOutline,
  GdsIcon.bold,
  GdsIcon.bookmarkFill,
  GdsIcon.bookmarkOutline,
  GdsIcon.cameraFill,
  GdsIcon.cameraOutline,
  GdsIcon.chatRound,
  GdsIcon.checkCircleFill,
  GdsIcon.checkCircleOutline,
  GdsIcon.checkSquareFill,
  GdsIcon.checkSquareOutline,
  GdsIcon.check,
  GdsIcon.chevronDoubleLeftThick,
  GdsIcon.chevronDoubleLeft,
  GdsIcon.chevronDoubleRightThick,
  GdsIcon.chevronDoubleRight,
  GdsIcon.chevronDownThick,
  GdsIcon.chevronDown,
  GdsIcon.chevronLeftThick,
  GdsIcon.chevronLeftTightThick,
  GdsIcon.chevronLeftTight,
  GdsIcon.chevronLeft,
  GdsIcon.chevronRightThick,
  GdsIcon.chevronRightTightThick,
  GdsIcon.chevronRightTight,
  GdsIcon.chevronRight,
  GdsIcon.chevronUpThick,
  GdsIcon.chevronUp,
  GdsIcon.closeCircleFill,
  GdsIcon.closeCircleOutline,
  GdsIcon.closeSquareFill,
  GdsIcon.closeSquareOutline,
  GdsIcon.dangerCircleFill,
  GdsIcon.dangerCircleOutline,
  GdsIcon.dangerTriangleFill,
  GdsIcon.dangerTriangleOutline,
  GdsIcon.dislikeFill,
  GdsIcon.dislikeOutline,
  GdsIcon.dotMenuHorizontal,
  GdsIcon.dotMenuVertical,
  GdsIcon.download,
  GdsIcon.eyeOff,
  GdsIcon.eyeOn,
  GdsIcon.folderEdit,
  GdsIcon.fontBg,
  GdsIcon.fontColor,
  GdsIcon.forward2,
  GdsIcon.forward,
  GdsIcon.galleryEdit,
  GdsIcon.galleryFill,
  GdsIcon.galleryOutline,
  GdsIcon.galleryWideFill,
  GdsIcon.galleryWideOutline,
  GdsIcon.hamburgerThick,
  GdsIcon.hamburger,
  GdsIcon.head,
  GdsIcon.heartFill,
  GdsIcon.heartOutline,
  GdsIcon.signOut,
  GdsIcon.inbox,
  GdsIcon.infoCircleFill,
  GdsIcon.infoCircleOutline,
  GdsIcon.italic,
  GdsIcon.keyboardHide,
  GdsIcon.keyboardShow,
  GdsIcon.likeFill,
  GdsIcon.likeOutline,
  GdsIcon.link,
  GdsIcon.magnifierFill,
  GdsIcon.magnifierOutline,
  GdsIcon.minusCircleFill,
  GdsIcon.minusCircleOutline,
  GdsIcon.minusThick,
  GdsIcon.minus,
  GdsIcon.signIn,
  GdsIcon.penFill,
  GdsIcon.penOutline,
  GdsIcon.pen2Fill,
  GdsIcon.pen2Outline,
  GdsIcon.personFill,
  GdsIcon.personOutline,
  GdsIcon.plusThick,
  GdsIcon.plus,
  GdsIcon.questionCircleFill,
  GdsIcon.questionCircleOutline,
  GdsIcon.redo,
  GdsIcon.reply2,
  GdsIcon.reply,
  GdsIcon.settings,
  GdsIcon.share,
  GdsIcon.sirenFill,
  GdsIcon.sirenOutline,
  GdsIcon.sortHorizontal,
  GdsIcon.strikeout,
  GdsIcon.trash,
  GdsIcon.underline,
  GdsIcon.undo,
  GdsIcon.xMarkThick,
  GdsIcon.xMark,
];

const _brandIcons = [
  GdsIcon.apple,
  GdsIcon.email,
  GdsIcon.facebookBg,
  GdsIcon.facebook,
  GdsIcon.google,
  GdsIcon.instagramBg,
  GdsIcon.instagram,
  GdsIcon.kakaotalkBg,
  GdsIcon.kakaotalkSimple,
  GdsIcon.kakaotalk,
  GdsIcon.pixivBg,
  GdsIcon.pixiv,
  GdsIcon.threadBg,
  GdsIcon.thread,
  GdsIcon.xBg,
  GdsIcon.x,
  GdsIcon.youtubeBg,
  GdsIcon.youtube,
];

const _logoIcons = [
  GdsIcon.faviconBlack,
  GdsIcon.faviconBlackBg,
  GdsIcon.faviconWhite,
  GdsIcon.faviconWhiteBg,
  GdsIcon.logo,
];

const _navigationIcons = [
  GdsIcon.board,
  GdsIcon.following,
  GdsIcon.home,
  GdsIcon.message,
  GdsIcon.paint,
];

const _graphicIcons = [
  GdsIcon.rank1,
  GdsIcon.rank2,
  GdsIcon.rank3,
  GdsIcon.rank4,
];

const _illustIcons = [
  GdsIcon.alarm,
  GdsIcon.illust,
  GdsIcon.illustReply,
  GdsIcon.resultNull,
  GdsIcon.success,
  GdsIcon.uploadSuccess,
  GdsIcon.user,
  GdsIcon.warning,
];
