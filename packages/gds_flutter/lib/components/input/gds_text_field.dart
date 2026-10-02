// ignore_for_file: gds_lints/valid_gds_spacing

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/input/gds_input_count.dart';
import 'package:gds_flutter/components/input/gds_input_decoration.dart';
import 'package:gds_flutter/components/input/gds_input_frame.dart';
import 'package:gds_flutter/components/input/gds_input_style.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 디자인 시스템에서 사용하는 단일 라인 기반의 입력 필드 위젯.
abstract class GdsTextField {
  static final _mdDecoration = GdsInputDecoration(
    typography: .label2,
    spacing: 8,
    border: .all(),
    radius: .sm,
    padding: .symmetric(horizontal: 16, vertical: 14.8), // 고정 높이 52px 기준
  );

  static final _smDecoration = GdsInputDecoration(
    typography: .label4,
    spacing: 8,
    border: .all(),
    radius: .sm,
    padding: .symmetric(horizontal: 12, vertical: 11.2), // 고정 높이 42px 기준
  );

  /// 일반적인 텍스트를 입력할 때 사용하는 입력 필드 위젯.
  /// 한 줄 크기를 유지하며 내용에 따라 [maxLines]까지 높이가 늘어납니다.
  @GdsSupportedSizes([.md, .sm])
  static Widget normal({
    Key? key,
    required GdsSize size,
    GdsInputStatus status = .enabled,
    GdsShadow? shadow,
    String? placeholder,
    String? initialText,
    String? prefixText,
    String? mentionText,
    bool? obscureText,
    GdsIcon? leadingIcon,
    GdsIcon? trailingIcon,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onComplete,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    int? maxLength,
    int minLines = 1,
    int maxLines = 1,
  }) {
    assert(mentionText == null || leadingIcon == null);
    assert(maxLength == null || trailingIcon == null);

    /// 입력 필드에 적절한 형태로 아이콘을 빌드합니다.
    Widget buildIcon(GdsIcon icon) {
      return icon.build(
        size: 16,
        color: status == .disabled ? .iconGraySubtler : .iconGrayNormal,
      );
    }

    final style = GdsInputStyle(
      leadingBuilder: (context, controller) {
        // 좌측 아이콘 표시
        if (leadingIcon != null) {
          return buildIcon(leadingIcon);
        }

        // 멘션 텍스트 표시
        if (mentionText != null) {
          return GdsTransition.sharedAxis(
            transitionType: .vertical,
            alignment: .centerLeft,
            value: mentionText,
            child: GdsText(
              '@[$mentionText]',
              color: .textPrimaryNormal,
              style: size.when(md: .label3, sm: .label5),
            ),
          );
        }

        return null;
      },
      trailingBuilder: (context, controller) {
        // 우측 아이콘 표시
        if (trailingIcon != null) {
          return buildIcon(trailingIcon);
        }

        // 글자 수 카운터 표시
        if (maxLength != null) {
          return GdsInputCount(count: controller.text.length, maxCount: maxLength);
        }

        return null;
      },
    );

    return GdsInputFrame(
      key: key,
      enabledStyle: style.copyWith(
        borderColor: .borderGraySubtle,
        textColor: .textGraySubtle,
      ),
      filledStyle: style.copyWith(
        borderColor: .borderGraySubtle,
        textColor: .textGrayBold,
      ),
      focusedStyle: style.copyWith(
        borderColor: .statusInfo,
        textColor: .textGrayBold,
      ),
      errorStyle: style.copyWith(
        backgroundColor: .statusNegative,
        backgroundOpacity: GdsOpacity.opacity10,
        borderColor: .statusNegative,
        cursorColor: .statusNegative,
        textColor: .textGrayBold,
      ),
      successStyle: style.copyWith(
        borderColor: .statusPositive,
        cursorColor: .statusPositive,
        textColor: .textGrayBold,
      ),
      disabledStyle: style.copyWith(
        backgroundColor: .surfaceGraySubtlest,
        borderColor: .borderGraySubtler,
        textColor: .textGraySubtler,
      ),
      decoration: size.when(
        md: _mdDecoration.copyWith(size: .lg),
        sm: _smDecoration.copyWith(size: .md),
      ),
      status: status,
      shadow: shadow,
      placeholder: placeholder,
      initialText: initialText,
      prefixText: prefixText,
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      onComplete: onComplete,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      axis: .horizontal,
    );
  }

  /// 검색어를 입력할 때 사용하는 입력 필드 위젯.
  @GdsSupportedSizes([.md, .sm])
  static Widget search({
    Key? key,
    required GdsSize size,
    GdsShadow? shadow,
    String? placeholder,
    String? initialText,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onComplete,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
  }) {
    final style = GdsInputStyle(
      backgroundColor: .surfaceGraySubtlest,
      borderColor: .borderGraySubtle,
      leadingBuilder: (context, controller) {
        return GdsIcon.magnifier.build(size: 20, color: .iconGrayNormal);
      },
      trailingBuilder: (context, controller) {
        if (controller.text.isNotEmpty) {
          return GdsGesture(
            onTap: controller.clear,
            child: GdsIcon.closeCircleFill.build(size: 24, color: .iconGraySubtle),
          );
        }

        return null;
      },
    );

    return GdsInputFrame(
      key: key,
      enabledStyle: style.copyWith(textColor: .textGraySubtle),
      filledStyle: style.copyWith(textColor: .textGrayBold),
      focusedStyle: style.copyWith(textColor: .textGrayBold),
      errorStyle: .new(),
      successStyle: .new(),
      disabledStyle: .new(),
      decoration: size.when(
        md: _mdDecoration.copyWith(size: .ml, padding: .symmetric(horizontal: 16, vertical: 12.8)), // 고정 높이 48px 기준
        sm: _smDecoration.copyWith(size: .md),
      ),
      status: .enabled,
      shadow: shadow,
      placeholder: placeholder,
      initialText: initialText,
      prefixText: null,
      obscureText: null,
      onSubmitted: onSubmitted,
      onComplete: onComplete,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: null,
      minLines: 1,
      maxLines: 1,
      axis: .horizontal,
    );
  }

  /// 제목을 입력할 때 사용하는 입력 필드 위젯.
  @GdsSupportedSizes([.md, .sm])
  static Widget title({
    Key? key,
    required GdsSize size,
    GdsInputStatus status = .enabled,
    GdsShadow? shadow,
    String? placeholder,
    String? initialText,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onComplete,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    required int maxLength,
  }) {
    final style = GdsInputStyle(
      borderColor: .borderGraySubtle,
      trailingBuilder: (context, controller) {
        return GdsInputCount(count: controller.text.length, maxCount: maxLength);
      },
    );

    return GdsInputFrame(
      key: key,
      enabledStyle: style.copyWith(textColor: .textGraySubtle),
      filledStyle: style.copyWith(textColor: .textGrayBold),
      focusedStyle: style.copyWith(
        borderColor: .statusInfo,
        textColor: .textGrayBold,
      ),
      errorStyle: style.copyWith(
        borderColor: .statusNegative,
        textColor: .textGrayBold,
      ),
      successStyle: style.copyWith(
        borderColor: .statusPositive,
        textColor: .textGrayBold,
      ),
      disabledStyle: style.copyWith(
        borderColor: .borderGraySubtle,
        textColor: .textGraySubtler,
      ),
      decoration: size.when(
        md: .new(
          typography: .title2,
          spacing: 8,
          border: .new(bottom: 1), // 아래쪽만
          padding: .symmetric(horizontal: 12, vertical: 11.6), // 고정 높이 52px 기준
          size: .lg,
          alignment: .end,
        ),
        sm: .new(
          typography: .label2,
          spacing: 8,
          border: .new(bottom: 1), // 아래쪽만
          padding: .symmetric(vertical: 9.8), // 고정 높이 42px 기준
          size: .md,
        ),
      ),
      status: status,
      shadow: shadow,
      placeholder: placeholder,
      initialText: initialText,
      prefixText: null,
      obscureText: null,
      onSubmitted: onSubmitted,
      onComplete: onComplete,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      minLines: 1,
      maxLines: 1,
      axis: .horizontal,
    );
  }
}
