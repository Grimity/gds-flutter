// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/input/gds_input_decoration.dart';
import 'package:gds_flutter/components/input/gds_input_style.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:pervice/pervice.dart';

/// 상태와 크기에 맞는 스타일 및 배치를 적용하는 입력 필드의 기본 프레임.
class GdsInputFrame extends StatelessWidget {
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
    required this.text,
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
  final String? text;
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
  Widget build(BuildContext context) {
    assert(axis != .horizontal || height == null);
    assert(axis != .vertical || height != null);

    final controller = this.controller ?? context.useTextEditingController(text: initialText);
    final focusNode = this.focusNode ?? context.useFocusNode();

    // 주어진 값과 현재 입력값과 다르면 반영.
    if (text case final text? when text != controller.text) {
      controller.text = text;
    }

    return IgnorePointer(
      ignoring: status == .disabled,
      child: ListenableBuilder(
        listenable: .merge([
          controller,
          focusNode,
        ]),
        builder: (context, child) {
          // 입력된 텍스트가 있는지 여부.
          final isFilled = controller.text.isNotEmpty;

          // 현재 포커스된 상태인지 여부.
          final isFocused = focusNode.hasFocus;

          // 입력 상태와 포커스, 입력 여부에 대응하는 스타일.
          final GdsInputStyle style = switch (status) {
            .enabled when isFocused => focusedStyle,
            .enabled when isFilled => filledStyle,
            .enabled => enabledStyle,
            .error => errorStyle,
            .success => successStyle,
            .disabled => disabledStyle,
          };

          final cursorColor = style.cursorColor ?? .statusInfo;
          final borderColor = style.borderColor;
          final textStyle = decoration.typography.style;
          final leading = style.leadingBuilder?.call(context, controller);
          final trailing = style.trailingBuilder?.call(context, controller);
          final children = [
            // 왼쪽 혹은 위쪽 위젯 표시.
            GdsFoldable.builder(
              alignment: alignmentOf(axis == .vertical ? .up : .left),
              visible: leading != null,
              axis: axis,
              builder: (context) {
                return Padding(
                  padding: switch (axis) {
                    .vertical => .only(bottom: decoration.spacing),
                    .horizontal => .only(right: decoration.spacing),
                  },
                  child: leading,
                );
              },
            ),

            // 접두어 텍스트 표시.
            if (prefixText != null) ...[
              GdsText(
                '$prefixText',
                style: decoration.typography,
                color: .textGraySubtle,
              ),
            ],

            Expanded(
              child: Stack(
                alignment: axis == .vertical ? .topLeft : .centerLeft,
                children: [
                  // 안내 텍스트 표시.
                  if (placeholder != null && !isFilled) ...[
                    GdsText(
                      placeholder!,
                      style: decoration.typography,
                      color: status == .disabled
                          ? disabledStyle.textColor ?? .transparent
                          : enabledStyle.textColor ?? .transparent,
                    ),
                  ],

                  // 입력 필드 표시.
                  EditableText(
                    controller: controller,
                    focusNode: focusNode,
                    cursorColor: cursorColor.of(context),
                    backgroundCursorColor: cursorColor.of(context),
                    style: textStyle.copyWith(color: style.textColor?.of(context)),
                    scrollPadding: .zero,
                    keyboardType: keyboardType,
                    obscureText: obscureText ?? false,
                    minLines: minLines,
                    maxLines: maxLines,
                    onTapUpOutside: (_) {
                      focusNode.unfocus();
                    },
                    onEditingComplete: () {
                      focusNode.unfocus();
                      onComplete?.call();
                    },
                    onSubmitted: (newValue) {
                      onSubmitted?.call(newValue.trim());
                    },
                    onChanged: (newValue) {
                      onChanged?.call(newValue.trim());
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(maxLength),
                    ],
                  ),
                ],
              ),
            ),

            // 오른쪽 혹은 아래쪽 위젯 표시.
            GdsFoldable.builder(
              alignment: alignmentOf(axis == .vertical ? .down : .right),
              visible: trailing != null,
              axis: axis,
              builder: (context) {
                return Padding(
                  padding: switch (axis) {
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
            onTap: focusNode.requestFocus,
            child: GdsContainer(
              animation: .fast,
              height: height,
              radius: decoration.radius,
              color: style.backgroundColor,
              opacity: style.backgroundOpacity,
              border: borderColor != null ? decoration.border?.copyWith(color: borderColor) : null,
              shadow: shadow,
              padding: decoration.padding,
              child: Flex(
                direction: axis,
                crossAxisAlignment: decoration.alignment,
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }

  /// 지정한 방향과 입력 필드의 교차축 정렬에 대응하는 정렬 값을 반환합니다.
  Alignment alignmentOf(AxisDirection direction) {
    final alignment = decoration.alignment;
    final crossAxis = switch (alignment) {
      .start => -1.0,
      .end => 1.0,
      .center || .stretch || .baseline => 0.0,
    };

    return switch (direction) {
      .up => .new(crossAxis, -1),
      .down => .new(crossAxis, 1),
      .left => .new(-1, crossAxis),
      .right => .new(1, crossAxis),
    };
  }
}
