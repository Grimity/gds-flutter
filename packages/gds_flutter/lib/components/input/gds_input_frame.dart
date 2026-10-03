import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/input/gds_input_decoration.dart';
import 'package:gds_flutter/components/input/gds_input_style.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 상태와 크기에 맞는 스타일 및 배치를 적용하는 입력 필드의 기본 프레임.
class GdsInputFrame extends StatefulWidget {
  const new({
    super.key,
    required this.enabledStyle,
    required this.filledStyle,
    required this.focusedStyle,
    required this.errorStyle,
    required this.successStyle,
    required this.disabledStyle,
    required this.decoration,
    required this.status,
    required this.placeholder,
    required this.initialText,
    required this.prefixText,
    required this.obscureText,
    this.shadow,
    required this.onSubmitted,
    required this.onComplete,
    required this.onChanged,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    required this.maxLength,
    required this.axis,
    required this.minLines,
    required this.maxLines,
    this.height,
  });

  final GdsInputStyle enabledStyle;
  final GdsInputStyle filledStyle;
  final GdsInputStyle focusedStyle;
  final GdsInputStyle errorStyle;
  final GdsInputStyle successStyle;
  final GdsInputStyle disabledStyle;
  final GdsInputDecoration decoration;
  final GdsInputStatus status;
  final GdsShadow? shadow;
  final String? placeholder;
  final String? initialText;
  final String? prefixText;
  final bool? obscureText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Axis axis;
  final int? minLines;
  final int? maxLines;
  final double? height;

  @override
  State<GdsInputFrame> createState() => _GdsInputFrameState();
}

class _GdsInputFrameState extends State<GdsInputFrame> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  bool get isFilled => _controller.text.isNotEmpty;
  bool get isFocused => _focusNode.hasFocus;

  GdsInputStyle get style {
    if (widget.status == .enabled) {
      if (isFocused) return widget.focusedStyle;
      if (isFilled) return widget.filledStyle;
    }

    return switch (widget.status) {
      .enabled => widget.enabledStyle,
      .error => widget.errorStyle,
      .success => widget.successStyle,
      .disabled => widget.disabledStyle,
    };
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? .new(text: widget.initialText);
    _focusNode = widget.focusNode ?? .new();
  }

  @override
  void didUpdateWidget(covariant GdsInputFrame oldWidget) {
    super.didUpdateWidget(oldWidget);

    // controller 속성이 변경되었을 경우.
    if (widget.controller != oldWidget.controller) {
      // 오직 컨트롤러를 소유한 경우에만 폐기.
      if (oldWidget.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? .new(text: widget.initialText);
    }

    // focusNode 속성이 변경되었을 경우.
    if (widget.focusNode != oldWidget.focusNode) {
      // 오직 포커스 노드를 소유한 경우에만 폐기.
      if (oldWidget.focusNode == null) {
        _focusNode.dispose();
      }

      _focusNode = widget.focusNode ?? .new();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.axis != .horizontal || widget.height == null);
    assert(widget.axis != .vertical || widget.height != null);

    return IgnorePointer(
      ignoring: widget.status == .disabled,
      child: ListenableBuilder(
        listenable: .merge([_controller, _focusNode]),
        builder: (context, child) {
          final cursorColor = style.cursorColor ?? .statusInfo;
          final borderColor = style.borderColor;
          final decoration = widget.decoration;
          final textStyle = decoration.typography.style;
          final leading = style.leadingBuilder?.call(context, _controller);
          final trailing = style.trailingBuilder?.call(context, _controller);
          final children = [
            // 왼쪽 혹은 위쪽 위젯 표시.
            GdsFoldable.builder(
              alignment: alignmentOf(widget.axis == .vertical ? .up : .left),
              visible: leading != null,
              axis: widget.axis,
              builder: (context) {
                return Padding(
                  padding: switch (widget.axis) {
                    .vertical => .only(bottom: decoration.spacing),
                    .horizontal => .only(right: decoration.spacing),
                  },
                  child: leading,
                );
              },
            ),

            // 접두어 텍스트 표시.
            if (widget.prefixText != null) ...[
              GdsText(
                widget.prefixText.toString(),
                style: decoration.typography,
                color: .textGraySubtle,
              ),
            ],

            Expanded(
              child: Stack(
                alignment: widget.axis == .vertical ? .topLeft : .centerLeft,
                children: [
                  // 안내 텍스트 표시.
                  if (widget.placeholder != null && !isFilled) ...[
                    GdsText(
                      widget.placeholder!,
                      style: decoration.typography,
                      color: widget.status == .disabled
                          ? widget.disabledStyle.textColor ?? .transparent
                          : widget.enabledStyle.textColor ?? .transparent,
                    ),
                  ],

                  // 입력 필드 표시.
                  EditableText(
                    controller: _controller,
                    focusNode: _focusNode,
                    cursorColor: cursorColor.of(context),
                    backgroundCursorColor: cursorColor.of(context),
                    style: textStyle.copyWith(color: style.textColor?.of(context)),
                    scrollPadding: .zero,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscureText ?? false,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    onTapUpOutside: (_) {
                      _focusNode.unfocus();
                    },
                    onEditingComplete: () {
                      _focusNode.unfocus();
                      widget.onComplete?.call();
                    },
                    onSubmitted: widget.onSubmitted,
                    onChanged: widget.onChanged,
                    inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
                  ),
                ],
              ),
            ),

            // 오른쪽 혹은 아래쪽 위젯 표시.
            GdsFoldable.builder(
              alignment: alignmentOf(widget.axis == .vertical ? .down : .right),
              visible: trailing != null,
              axis: widget.axis,
              builder: (context) {
                return Padding(
                  padding: switch (widget.axis) {
                    .vertical => .only(top: decoration.spacing),
                    .horizontal => .only(left: decoration.spacing),
                  },
                  child: trailing,
                );
              },
            ),
          ];

          return GdsGesture(
            useEffect: false,
            cursor: SystemMouseCursors.text,
            onTap: _focusNode.requestFocus,
            child: GdsContainer(
              animation: .fast,
              height: widget.height,
              radius: decoration.radius,
              color: style.backgroundColor,
              opacity: style.backgroundOpacity,
              border: borderColor != null ? decoration.border?.copyWith(color: borderColor) : null,
              shadow: widget.shadow,
              padding: decoration.padding,
              child: switch (widget.axis) {
                .horizontal => Row(
                  crossAxisAlignment: decoration.alignment,
                  children: children,
                ),
                .vertical => Column(
                  crossAxisAlignment: decoration.alignment,
                  children: children,
                ),
              },
            ),
          );
        },
      ),
    );
  }

  /// 지정한 방향과 입력 필드의 교차축 정렬에 대응하는 정렬 값을 반환합니다.
  Alignment alignmentOf(AxisDirection direction) {
    final alignment = widget.decoration.alignment;
    final crossAxis = switch (alignment) {
      .start => -1.0,
      .end => 1.0,
      .center || .stretch || .baseline => 0.0,
    };

    return switch (direction) {
      .up => Alignment(crossAxis, -1),
      .down => Alignment(crossAxis, 1),
      .left => Alignment(-1, crossAxis),
      .right => Alignment(1, crossAxis),
    };
  }
}
