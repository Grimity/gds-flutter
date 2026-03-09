import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

enum GdsGroupSettingState {
  enabled,
  pressed,
  delete,
  editDelete,
  disabled;

  bool get isDisabled => this == GdsGroupSettingState.disabled;

  bool get showsLeadingIcon => switch (this) {
    GdsGroupSettingState.enabled => false,
    GdsGroupSettingState.pressed => false,
    GdsGroupSettingState.delete => false,
    GdsGroupSettingState.editDelete => true,
    GdsGroupSettingState.disabled => true,
  };

  bool get blocksTextFieldInteraction => switch (this) {
    GdsGroupSettingState.enabled => false,
    GdsGroupSettingState.pressed => true,
    GdsGroupSettingState.delete => false,
    GdsGroupSettingState.editDelete => true,
    GdsGroupSettingState.disabled => true,
  };

  GdsIcon get trailingIcon => switch (this) {
    GdsGroupSettingState.enabled => GdsIcon.hamburger,
    GdsGroupSettingState.pressed => GdsIcon.hamburger,
    GdsGroupSettingState.delete => GdsIcon.minusCircleFill,
    GdsGroupSettingState.editDelete => GdsIcon.minusCircleFill,
    GdsGroupSettingState.disabled => GdsIcon.minusCircleFill,
  };
}

class GdsGroupSetting extends StatefulWidget {
  const GdsGroupSetting({
    super.key,
    required this.text,
    this.state = GdsGroupSettingState.enabled,
    this.controller,
    this.focusNode,
    this.onTap,
    this.onEditTap,
    this.onChanged,
    this.onEditingComplete,
  });

  static const double _height = 52;

  final String text;
  final GdsGroupSettingState state;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  State<GdsGroupSetting> createState() => _GdsGroupSettingState();
}

class _GdsGroupSettingState extends State<GdsGroupSetting> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _initController();
    _initFocusNode();
  }

  void _initController() {
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.text);
      _ownsController = true;
    } else {
      _controller = widget.controller!;
      _ownsController = false;
      if (_controller.text.isEmpty && widget.text.isNotEmpty) {
        _controller.text = widget.text;
      }
    }
  }

  void _initFocusNode() {
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
      _ownsFocusNode = false;
    }
  }

  @override
  void didUpdateWidget(covariant GdsGroupSetting oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      if (_ownsController) _controller.dispose();
      _initController();
    } else if (_ownsController && oldWidget.text != widget.text && _controller.text != widget.text) {
      _controller.value = _controller.value.copyWith(
        text: widget.text,
        selection: TextSelection.collapsed(offset: widget.text.length),
        composing: TextRange.empty,
      );
    }

    if (widget.focusNode != oldWidget.focusNode) {
      if (_ownsFocusNode) _focusNode.dispose();
      _initFocusNode();
    }
  }

  @override
  void dispose() {
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;
    final style = _GdsGroupSettingStyle.from(colors, state: widget.state);

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: _GdsGroupSettingTextField(
              controller: _controller,
              focusNode: _focusNode,
              state: widget.state,
              style: style,
              onTap: widget.onTap,
              onEditTap: widget.onEditTap,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComplete,
            ),
          ),
          const SizedBox(width: GdsSpacing.spacing8),
          widget.state.trailingIcon.build(
            color: style.trailingIconColor,
            width: GdsIconSize.v24,
            height: GdsIconSize.v24,
          ),
        ],
      ),
    );
  }
}

class _GdsGroupSettingTextField extends StatelessWidget {
  const _GdsGroupSettingTextField({
    required this.controller,
    required this.focusNode,
    required this.state,
    required this.style,
    this.onTap,
    this.onEditTap,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final GdsGroupSettingState state;
  final _GdsGroupSettingStyle style;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final blocksTextFieldInteraction = state.blocksTextFieldInteraction;

    final field = Container(
      height: GdsGroupSetting._height,
      padding: const EdgeInsets.symmetric(horizontal: GdsSpacing.spacing16),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(GdsRadius.sm)),
        border: Border.all(
          color: style.borderColor,
          width: 1,
        ),
        boxShadow: style.boxShadow,
      ),
      child: Row(
        children: [
          if (state.showsLeadingIcon) ...[
            SizedBox(
              width: GdsIconSize.v16,
              height: GdsIconSize.v16,
              child: GdsIcon.penFill.build(
                color: style.leadingIconColor,
                width: GdsIconSize.v16,
                height: GdsIconSize.v16,
              ),
            ),
            const SizedBox(width: GdsSpacing.spacing8),
          ],
          Expanded(
            child: IgnorePointer(
              ignoring: blocksTextFieldInteraction,
              child: EditableText(
                controller: controller,
                focusNode: focusNode,
                style: GdsTypography.label1.copyWith(color: style.textColor),
                cursorColor: style.cursorColor,
                backgroundCursorColor: GdsColors.transparent,
                selectionColor: style.selectionColor,
                maxLines: 1,
                readOnly: blocksTextFieldInteraction,
                showCursor: !blocksTextFieldInteraction,
                onChanged: onChanged,
                onEditingComplete: onEditingComplete,
              ),
            ),
          ),
        ],
      ),
    );

    if (state == GdsGroupSettingState.editDelete) {
      return GdsGesture(
        onTap: onEditTap,
        child: field,
      );
    }

    return field;
  }
}

class _GdsGroupSettingStyle {
  const _GdsGroupSettingStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.leadingIconColor,
    required this.trailingIconColor,
    required this.cursorColor,
    required this.selectionColor,
    required this.boxShadow,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color leadingIconColor;
  final Color trailingIconColor;
  final Color cursorColor;
  final Color selectionColor;
  final List<BoxShadow>? boxShadow;

  static _GdsGroupSettingStyle from(
    GdsSemanticColor colors, {
    required GdsGroupSettingState state,
  }) {
    return switch (state) {
      GdsGroupSettingState.enabled => _GdsGroupSettingStyle(
        backgroundColor: colors.surface.base,
        borderColor: colors.border.graySubtle,
        textColor: colors.text.grayBold,
        leadingIconColor: colors.icon.grayBold,
        trailingIconColor: colors.icon.grayBold,
        cursorColor: colors.status.info,
        selectionColor: colors.status.info.withValues(alpha: GdsOpacity.opacity20),
        boxShadow: null,
      ),
      GdsGroupSettingState.pressed => _GdsGroupSettingStyle(
        backgroundColor: colors.surface.base,
        borderColor: colors.border.graySubtle,
        textColor: colors.text.grayBold,
        leadingIconColor: colors.icon.grayBold,
        trailingIconColor: colors.icon.grayBold,
        cursorColor: colors.status.info,
        selectionColor: colors.status.info.withValues(alpha: GdsOpacity.opacity20),
        boxShadow: GdsShadows.level1,
      ),
      GdsGroupSettingState.delete => _GdsGroupSettingStyle(
        backgroundColor: colors.surface.base,
        borderColor: colors.border.graySubtle,
        textColor: colors.text.grayBold,
        leadingIconColor: colors.icon.grayBold,
        trailingIconColor: colors.icon.grayNormal,
        cursorColor: colors.status.info,
        selectionColor: colors.status.info.withValues(alpha: GdsOpacity.opacity20),
        boxShadow: null,
      ),
      GdsGroupSettingState.editDelete => _GdsGroupSettingStyle(
        backgroundColor: colors.surface.base,
        borderColor: colors.border.graySubtle,
        textColor: colors.text.grayBold,
        leadingIconColor: colors.icon.grayBold,
        trailingIconColor: colors.icon.grayNormal,
        cursorColor: colors.status.info,
        selectionColor: colors.status.info.withValues(alpha: GdsOpacity.opacity20),
        boxShadow: null,
      ),
      GdsGroupSettingState.disabled => _GdsGroupSettingStyle(
        backgroundColor: colors.surface.graySubtlest,
        borderColor: colors.border.graySubtler,
        textColor: colors.text.graySubtler,
        leadingIconColor: colors.icon.graySubtler,
        trailingIconColor: colors.icon.graySubtler,
        cursorColor: GdsColors.transparent,
        selectionColor: GdsColors.transparent,
        boxShadow: null,
      ),
    };
  }
}
