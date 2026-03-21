import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

enum GdsEditorDecorationType {
  plus(GdsIcon.plus),
  fontSize(GdsIcon.head),
  fontColor(GdsIcon.fontColor),
  fontBgColor(GdsIcon.fontBg),
  bold(GdsIcon.bold),
  italic(GdsIcon.italic),
  underline(GdsIcon.underline),
  strikethrough(GdsIcon.strikeout);

  final GdsIcon icon;
  const GdsEditorDecorationType(this.icon);

  Color getBackgroundColor(BuildContext context) {
    final colors = context.gdsColors;
    return switch (this) {
      GdsEditorDecorationType.bold ||
      GdsEditorDecorationType.italic ||
      GdsEditorDecorationType.underline ||
      GdsEditorDecorationType.strikethrough => colors.surface.grayBold,
      _ => colors.surface.graySubtler,
    };
  }

  Color getForegroundColor(BuildContext context) {
    final colors = context.gdsColors;
    return switch (this) {
      GdsEditorDecorationType.bold ||
      GdsEditorDecorationType.italic ||
      GdsEditorDecorationType.underline ||
      GdsEditorDecorationType.strikethrough => colors.icon.inverse,
      _ => colors.icon.grayBold,
    };
  }
}

enum GdsEditorDecorationState {
  enabled,
  pressed;

  static GdsEditorDecorationState fromPressed(bool value) {
    return value ? GdsEditorDecorationState.pressed : GdsEditorDecorationState.enabled;
  }
}

class GdsEditorDecoration extends StatelessWidget {
  final GdsEditorDecorationType? type;
  final GdsIcon? customIcon;
  final GdsEditorDecorationState state;
  final VoidCallback? onTap;

  const GdsEditorDecoration({
    super.key,
    required this.type,
    required this.state,
    this.onTap,
  }) : customIcon = null;

  const GdsEditorDecoration.byIcon({
    super.key,
    required GdsIcon icon,
    this.onTap,
  })  : type = null,
        customIcon = icon,
        state = GdsEditorDecorationState.enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final isPressed = state == GdsEditorDecorationState.pressed;

    if (customIcon != null) {
      return GdsGesture(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(GdsSpacing.spacing4),
          child: customIcon!.build(color: colors.icon.grayBold),
        ),
      );
    }

    final isFontBg = type == GdsEditorDecorationType.fontBgColor;

    return GdsGesture(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(GdsSpacing.spacing4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.xs),
          color: isPressed ? type!.getBackgroundColor(context) : null,
        ),
        child: type!.icon.build(
          colorMap: {
            'background': colors.surface.base,
            'foreground': colors.icon.grayBold,
            'border': colors.border.graySubtle,
          },
          color: isFontBg
              ? null
              : (isPressed ? type!.getForegroundColor(context) : colors.icon.grayBold),
        ),
      ),
    );
  }
}

enum GdsEditorButtonState {
  enabled,
  pressed,
  hovered;

  static GdsEditorButtonState fromPressed(bool value) {
    return value ? GdsEditorButtonState.pressed : GdsEditorButtonState.enabled;
  }
}

class GdsEditorButton {
  const GdsEditorButton._();

  static Color _getFontStyleColor(BuildContext context, GdsEditorButtonState state) {
    final colors = context.gdsColors;
    return switch (state) {
      GdsEditorButtonState.enabled => colors.text.grayNormal,
      GdsEditorButtonState.pressed => colors.text.primaryNormal,
      GdsEditorButtonState.hovered => colors.text.grayNormal,
    };
  }

  static Widget title1({
    required BuildContext context,
    required GdsEditorButtonState state,
    VoidCallback? onTap,
    String title = "가나다",
    String label = "제목 1",
  }) {
    return _PanelBaseButton(
      state: state,
      label: label,
      onTap: onTap,
      childBuilder: (context) => Text(
        title,
        style: GdsTypography.subtitle1.copyWith(color: _getFontStyleColor(context, state)),
      ),
    );
  }

  static Widget title2({
    required BuildContext context,
    required GdsEditorButtonState state,
    VoidCallback? onTap,
    String title = "가나다",
    String label = "제목 2",
  }) {
    return _PanelBaseButton(
      state: state,
      label: label,
      onTap: onTap,
      childBuilder: (context) => Text(
        title,
        style: GdsTypography.body1SB.copyWith(color: _getFontStyleColor(context, state)),
      ),
    );
  }

  static Widget body({
    required BuildContext context,
    required GdsEditorButtonState state,
    VoidCallback? onTap,
    String title = "가나다",
    String label = "본문",
  }) {
    return _PanelBaseButton(
      state: state,
      label: label,
      onTap: onTap,
      childBuilder: (context) => Text(
        title,
        style: GdsTypography.body1R.copyWith(color: _getFontStyleColor(context, state)),
      ),
    );
  }

  static Widget icon({
    required BuildContext context,
    required GdsEditorButtonState state,
    required GdsIcon icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return _PanelBaseButton(
      state: state,
      label: label,
      onTap: onTap,
      childBuilder: (context) => icon.build(color: _getFontStyleColor(context, state)),
    );
  }

  static Widget fontColor({
    required BuildContext context,
    required GdsEditorButtonState state,
    required Color color,
    VoidCallback? onTap,
  }) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: Container(
        width: GdsSpacing.spacing40,
        height: GdsSpacing.spacing40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.sm),
          color: state == GdsEditorButtonState.hovered ? colors.surface.graySubtler : null,
        ),
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: state == GdsEditorButtonState.pressed
                ? Border.all(color: colors.border.grayNormal)
                : null,
          ),
        ),
      ),
    );
  }

  static Widget fontBgColor({
    required BuildContext context,
    required GdsEditorButtonState state,
    required Color backgroundColor,
    required Color foregroundColor,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(GdsSpacing.spacing4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.sm),
          color: state == GdsEditorButtonState.hovered ? colors.surface.graySubtler : null,
        ),
        child: Container(
          padding: const EdgeInsets.all(GdsSpacing.spacing4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(GdsRadius.xs),
            color: state == GdsEditorButtonState.pressed ? colors.surface.graySubtler : null,
          ),
          child: GdsIcon.fontBg.build(
            colorMap: {
              'background': backgroundColor,
              'foreground': foregroundColor,
              'border': borderColor ?? colors.border.graySubtle,
            },
          ),
        ),
      ),
    );
  }
}

class _PanelBaseButton extends StatelessWidget {
  final WidgetBuilder childBuilder;
  final String label;
  final GdsEditorButtonState state;
  final VoidCallback? onTap;

  const _PanelBaseButton({
    required this.childBuilder,
    required this.label,
    required this.state,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return GdsGesture(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GdsRadius.sm),
          color: switch (state) {
            GdsEditorButtonState.enabled => null,
            GdsEditorButtonState.pressed => colors.surface.base,
            GdsEditorButtonState.hovered => colors.surface.graySubtler,
          },
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: GdsSpacing.spacing8,
          children:[
            childBuilder(context),
            Text(
              label,
              style: GdsTypography.label6.copyWith(
                color: switch (state) {
                  GdsEditorButtonState.enabled => colors.text.grayNormal,
                  GdsEditorButtonState.pressed => colors.text.primaryNormal,
                  GdsEditorButtonState.hovered => colors.text.grayNormal,
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum GdsEditorType {
  none("Default"),
  fontStyle("FontStyle"),
  plus("Plus"),
  fontColor("FontColor"),
  fontBgColor("FontBgColor");

  final String displayName;
  const GdsEditorType(this.displayName);
}

enum GdsEditorFontStyle {
  title1,
  title2,
  body,
}

enum GdsEditorColor {
  white(Color(0xFFFFFFFF)),
  black(Color(0xFF000000)),
  gray(Color(0xFF999999)),
  lightGray(Color(0xFFC4C4C4)),
  red(Color(0xFFF34343)),
  orange(Color(0xFFF89232)),
  yellow(Color(0xFFFFC824)),
  green(Color(0xFF3ECF45)),
  skyblue(Color(0xFF44ADF8)),
  blue(Color(0xFF3457EF)),
  pink(Color(0xFFF13087)),
  purple(Color(0xFFA724F8)),
  brown(Color(0xFF754611)),
  teal(Color(0xFF00DAA8));

  final Color color;
  const GdsEditorColor(this.color);

  Color get foregroundColor =>
      this == GdsEditorColor.white ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
}

class GdsEditor extends StatelessWidget {
  const GdsEditor({
    super.key,
    required this.type,
    this.fontStyle,
    this.fontColor,
    this.fontBgColor,
    this.isBoldPressed = false,
    this.isItalicPressed = false,
    this.isUnderlinePressed = false,
    this.isStrikethroughPressed = false,
    this.onPlus,
    this.onUndo,
    this.onRedo,
    this.onFontSize,
    this.onBold,
    this.onItalic,
    this.onUnderline,
    this.onStrikethrough,
    this.onFontColor,
    this.onFontBgColor,
    this.onKeyboard,
    this.onAddLink,
    this.onImageUpload,
    this.onFontStyleChanged,
    this.onFontColorChanged,
    this.onFontBgColorChanged,
  });

  final GdsEditorType type;
  final GdsEditorFontStyle? fontStyle;
  final GdsEditorColor? fontColor;
  final GdsEditorColor? fontBgColor;

  final bool isBoldPressed;
  final bool isItalicPressed;
  final bool isUnderlinePressed;
  final bool isStrikethroughPressed;

  final VoidCallback? onPlus;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final VoidCallback? onFontSize;
  final VoidCallback? onBold;
  final VoidCallback? onItalic;
  final VoidCallback? onUnderline;
  final VoidCallback? onStrikethrough;
  final VoidCallback? onFontColor;
  final VoidCallback? onFontBgColor;
  final VoidCallback? onKeyboard;
  final VoidCallback? onAddLink;
  final VoidCallback? onImageUpload;

  final ValueChanged<GdsEditorFontStyle>? onFontStyleChanged;
  final ValueChanged<GdsEditorColor>? onFontColorChanged;
  final ValueChanged<GdsEditorColor>? onFontBgColorChanged;

  @override
  Widget build(BuildContext context) {
    final Widget? panelContent = switch (type) {
      GdsEditorType.none => null,
      GdsEditorType.fontStyle => _buildFontStylePanel(context),
      GdsEditorType.plus => _buildPlusPanel(context),
      GdsEditorType.fontColor => _buildFontColorPanel(context),
      GdsEditorType.fontBgColor => _buildFontBgColorPanel(context),
    };

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          _buildToolbar(context),
          if (panelContent != null)
            Container(
              width: double.infinity,
              height: 120,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: GdsSpacing.spacing4,
                horizontal: GdsSpacing.spacing20,
              ),
              color: context.gdsColors.surface.graySubtlest,
              child: panelContent,
            ),
        ],
      ),
    );
  }

  Widget _buildFontStylePanel(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 120 * 3),
      child: Row(
        spacing: GdsSpacing.spacing8,
        children:[
          Expanded(
            child: GdsEditorButton.title1(
              context: context,
              state: GdsEditorButtonState.fromPressed(fontStyle == GdsEditorFontStyle.title1),
              onTap: () => onFontStyleChanged?.call(GdsEditorFontStyle.title1),
            ),
          ),
          Expanded(
            child: GdsEditorButton.title2(
              context: context,
              state: GdsEditorButtonState.fromPressed(fontStyle == GdsEditorFontStyle.title2),
              onTap: () => onFontStyleChanged?.call(GdsEditorFontStyle.title2),
            ),
          ),
          Expanded(
            child: GdsEditorButton.body(
              context: context,
              state: GdsEditorButtonState.fromPressed(fontStyle == GdsEditorFontStyle.body),
              onTap: () => onFontStyleChanged?.call(GdsEditorFontStyle.body),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlusPanel(BuildContext context) {
    return Row(
      spacing: GdsSpacing.spacing8,
      children:[
        Expanded(
          child: GdsEditorButton.icon(
            context: context,
            icon: GdsIcon.cameraOutline,
            label: '그림 업로드',
            state: GdsEditorButtonState.enabled,
            onTap: onImageUpload,
          ),
        ),
        Expanded(
          child: GdsEditorButton.icon(
            context: context,
            icon: GdsIcon.link,
            label: '링크 추가',
            state: GdsEditorButtonState.enabled,
            onTap: onAddLink,
          ),
        ),
      ],
    );
  }

  Widget _buildFontColorPanel(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Wrap(
        spacing: GdsSpacing.spacing8,
        runSpacing: GdsSpacing.spacing8,
        children: GdsEditorColor.values.map((value) {
          return GdsEditorButton.fontColor(
            context: context,
            color: value.color,
            state: GdsEditorButtonState.fromPressed(value == fontColor),
            onTap: () => onFontColorChanged?.call(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFontBgColorPanel(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Wrap(
        spacing: GdsSpacing.spacing8,
        runSpacing: GdsSpacing.spacing8,
        children: GdsEditorColor.values.map((value) {
          return GdsEditorButton.fontBgColor(
            context: context,
            backgroundColor: value.color,
            foregroundColor: value.foregroundColor,
            state: GdsEditorButtonState.fromPressed(value == fontBgColor),
            onTap: () => onFontBgColorChanged?.call(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    final colors = context.gdsColors;

    return Container(
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
      decoration: BoxDecoration(
        color: colors.surface.base,
        border: Border(top: BorderSide(color: colors.border.graySubtler)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildToolbarGroups(
          context: context,
          groups: [[
              GdsEditorDecoration(
                type: GdsEditorDecorationType.plus,
                state: GdsEditorDecorationState.fromPressed(type == GdsEditorType.plus),
                onTap: onPlus,
              ),
              GdsEditorDecoration.byIcon(icon: GdsIcon.undo, onTap: onUndo),
              GdsEditorDecoration.byIcon(icon: GdsIcon.redo, onTap: onRedo),
            ],[
              GdsEditorDecoration(
                type: GdsEditorDecorationType.fontSize,
                state: GdsEditorDecorationState.fromPressed(type == GdsEditorType.fontStyle),
                onTap: onFontSize,
              ),
              GdsEditorDecoration(
                type: GdsEditorDecorationType.bold,
                state: GdsEditorDecorationState.fromPressed(isBoldPressed),
                onTap: onBold,
              ),
              GdsEditorDecoration(
                type: GdsEditorDecorationType.italic,
                state: GdsEditorDecorationState.fromPressed(isItalicPressed),
                onTap: onItalic,
              ),
              GdsEditorDecoration(
                type: GdsEditorDecorationType.underline,
                state: GdsEditorDecorationState.fromPressed(isUnderlinePressed),
                onTap: onUnderline,
              ),
              GdsEditorDecoration(
                type: GdsEditorDecorationType.strikethrough,
                state: GdsEditorDecorationState.fromPressed(isStrikethroughPressed),
                onTap: onStrikethrough,
              ),
              GdsEditorDecoration(
                type: GdsEditorDecorationType.fontColor,
                state: GdsEditorDecorationState.fromPressed(type == GdsEditorType.fontColor),
                onTap: onFontColor,
              ),
              GdsEditorDecoration(
                type: GdsEditorDecorationType.fontBgColor,
                state: GdsEditorDecorationState.fromPressed(type == GdsEditorType.fontBgColor),
                onTap: onFontBgColor,
              ),
              GdsEditorDecoration.byIcon(icon: GdsIcon.keyboardHide, onTap: onKeyboard),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarGroups({
    required BuildContext context,
    required List<List<Widget>> groups,
  }) {
    final divider = GdsDivider.secondary(
      size: GdsDividerSize.vertical,
      extent: 22,
    );

    final List<Widget> children =[];
    for (int i = 0; i < groups.length; i++) {
      children.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: GdsSpacing.spacing8,
          children: groups[i],
        ),
      );
      if (i < groups.length - 1) {
        children.add(divider);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: GdsSpacing.spacing10,
      children: children,
    );
  }
}
