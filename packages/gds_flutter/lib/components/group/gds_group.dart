// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 그룹의 순서 변경 아이콘을 드래그 핸들로 구성하는 빌더.
typedef GdsGroupDragHandleBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// 그룹의 표시 상태를 나타내는 열거형.
enum GdsGroupStatus {
  enabled,
  disabled,
  selected,
  delete,
  editDelete,
}

/// Select, Accordion, Dropdown 등의 선택창을 보여줄 때 주로 사용되는 위젯.
class GdsGroup extends StatelessWidget {
  const new({
    super.key,
    this.status = .enabled,
    this.onTap,
    this.onHandleTap,
    this.dragHandleBuilder = defaultDragHandleBuilder,
    this.text,
    this.initialText,
    this.placeholder,
    this.onSubmitted,
    this.onComplete,
    this.onChanged,
  });

  final GdsGroupStatus status;
  final VoidCallback? onTap;
  final VoidCallback? onHandleTap;
  final GdsGroupDragHandleBuilder dragHandleBuilder;

  // GdsInputFrame
  final String? text;
  final String? initialText;
  final String? placeholder;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    // 삭제 아이콘을 표시하는지 여부.
    final isDelete = <GdsGroupStatus>{
      .delete,
      .editDelete,
      .disabled,
    }.contains(status);

    // 입력 필드 좌측에 편집 아이콘을 표시하는지 여부.
    final showLeadingIcon = <GdsGroupStatus>{
      .editDelete,
      .disabled,
    }.contains(status);

    // 입력 필드 우측에 표시할 아이콘 유형.
    final GdsIcon leadingIcon = isDelete ? .minusCircleFill : .hamburgerFill;

    return Row(
      spacing: 8,
      children: [
        // 상태에 따른 입력 필드 표시.
        Expanded(
          child: GdsGesture(
            onTap: onTap,
            child: IgnorePointer(
              ignoring: onTap != null,
              child: GdsTextField.normal(
                size: .md,
                text: text,
                initialText: initialText,
                placeholder: placeholder,
                leadingIcon: showLeadingIcon ? .penFill : null,
                status: .from(enabled: status != .disabled),
                shadow: status == .selected ? .level1 : null,
                onSubmitted: onSubmitted,
                onComplete: onComplete,
                onChanged: onChanged,
              ),
            ),
          ),
        ),

        // 우측에 삭제 또는 순서 변경 아이콘 표시.
        GdsGesture(
          onTap: onHandleTap,
          child: dragHandleBuilder(
            context,
            GdsTransition.crossFade(
              value: isDelete,
              child: leadingIcon.build(
                size: 24,
                color: status == .disabled ? .iconGraySubtlest : .iconGraySubtle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 별도의 드래그 처리 없이 주어진 핸들 위젯을 반환합니다.
  // ignore: gds_lints/prefer_widget_factory_key
  static Widget defaultDragHandleBuilder(BuildContext context, Widget child) {
    return child;
  }
}
