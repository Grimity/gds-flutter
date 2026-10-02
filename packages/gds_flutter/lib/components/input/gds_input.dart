import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/input/gds_reply_header.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 입력 필드와 제목 및 헬퍼 텍스트를 구성하는 위젯.
abstract class GdsInput {
  /// 제목과 헬퍼 텍스트를 함께 표시하는 입력 필드 위젯.
  static Widget title({
    Key? key,
    required GdsInputAction field,
    GdsTextButtonAction? button,
    String? title,
    String? helperText,
    bool required = false,
    GdsHelperTextStatus helperStatus = .enabled,
  }) {
    return Column(
      key: key,
      mainAxisSize: .min,
      children: [
        // 제목 텍스트 표시.
        if (title != null) ...[
          Padding(
            padding: .only(bottom: 8),
            child: Row(
              mainAxisAlignment: .start,
              spacing: 2,
              children: [
                GdsText(title, color: .textGrayBold, style: .label3),

                // 필수 입력이면 옆에 별표 표시.
                if (required) ...[
                  GdsText('*', color: .statusRed, style: .label3),
                ],
              ],
            ),
          ),
        ],

        Row(
          spacing: 8,
          children: [
            // 입력 필드 표시.
            Expanded(
              child: GdsTextField.normal(
                size: .md,
                placeholder: field.placeholder,
                onSubmitted: field.onSubmitted,
                onComplete: field.onComplete,
                onChanged: field.onChanged,
              ),
            ),

            // 옆에 버튼 표시.
            if (button != null) ...[
              GdsButton.text(
                type: .solid,
                size: .lg,
                onTap: button.onTap,
                label: button.label,
              ),
            ],
          ],
        ),

        // 헬퍼 텍스트 표시.
        GdsFoldable.builder(
          alignment: .topLeft,
          visible: helperText != null,
          axis: .vertical,
          builder: (context) {
            return Padding(
              padding: .only(top: 8),
              child: GdsTransition.sharedAxis(
                transitionType: .vertical,
                value: '$helperText, $helperStatus',
                child: GdsHelperText(text: helperText!, status: helperStatus),
              ),
            );
          },
        ),
      ],
    );
  }

  /// 답장할 사용자의 정보와 댓글에 대한 입력 필드 위젯.
  static Widget community({
    Key? key,
    required GdsInputAction field,
    required GdsTextButtonAction button,
    String? userName,
  }) {
    return GdsContainer(
      key: key,
      color: GdsColor.surfaceBase,
      border: .new(color: .borderGraySubtler, top: 1),
      child: Column(
        mainAxisSize: .min,
        children: [
          // 답장 헤더 표시.
          GdsFoldable.builder(
            alignment: .topCenter,
            visible: userName != null,
            axis: .vertical,
            builder: (context) {
              return Padding(
                padding: .only(top: 8, left: 16, right: 16, bottom: 4),
                child: GdsReplyHeader(text: '[$userName]님에게 답장'),
              );
            },
          ),

          // 입력 필드 및 버튼 표시.
          Padding(
            padding: .symmetric(vertical: 4, horizontal: 8),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: GdsTextField.normal(
                    size: .sm,
                    mentionText: userName,
                    placeholder: field.placeholder,
                    onSubmitted: field.onSubmitted,
                    onComplete: field.onComplete,
                    onChanged: field.onChanged,
                  ),
                ),
                GdsButton.text(
                  type: .solid,
                  size: .md,
                  onTap: button.onTap,
                  label: button.label,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
