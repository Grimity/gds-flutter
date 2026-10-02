import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 그룹의 표시 상태를 나타내는 열거형.
enum GdsGroupStatus {
  enabled,
  selected,
  delete,
  editDelete,
  disabled,
}

/// Select, Accordion, Dropdown 등의 선택창을 보여줄 때 주로 사용되는 위젯.
class GdsGroup extends StatelessWidget {
  const GdsGroup({
    super.key,
    this.status = .enabled,
    this.placeholder,
    this.onSubmitted,
    this.onComplete,
    this.onChanged,
  });

  final GdsGroupStatus status;

  // GdsInputFrame
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
    final leadingIcon = isDelete ? GdsIcon.minusCircleFill : GdsIcon.hamburgerFill;

    return Row(
      spacing: 8,
      children: [
        // 상태에 따른 입력 필드 표시.
        Expanded(
          child: GdsTextField.normal(
            size: .md,
            placeholder: placeholder,
            leadingIcon: showLeadingIcon ? .penFill : null,
            status: status == .disabled ? .disabled : .enabled,
            shadow: status == .selected ? .level1 : null,
            onSubmitted: onSubmitted,
            onComplete: onComplete,
            onChanged: onChanged,
          ),
        ),

        // 우측에 삭제 또는 순서 변경 아이콘 표시.
        GdsTransition.crossFade(
          value: isDelete,
          child: leadingIcon.build(
            size: 24,
            color: status == .disabled ? .iconGraySubtlest : .iconGraySubtle,
          ),
        ),
      ],
    );
  }
}
