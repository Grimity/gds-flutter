import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';
import 'package:gds_tokens/gds_tokens.dart';

part 'list_item/gds_section_list_item.dart';

part 'list_item/gds_right_icon_list_item.dart';

part 'list_item/gds_option_card_list_item.dart';

part 'list_item/gds_icon_list_item.dart';

part 'list_item/gds_picker_card_list_item.dart';

part 'list_item/gds_text_list_item.dart';

part 'list_item/gds_control_list_item.dart';

/// negative state 는 TextListItem 에만 사용(isNegative 로 제어)
enum GdsListItemState {
  enabled,
  focused,
  hovered,
  pressed,
  disabled;

  bool get isDisabled => this == GdsListItemState.disabled;
}

abstract class GdsListItem extends StatelessWidget {
  const GdsListItem({super.key});

  const factory GdsListItem.section({
    Key? key,
    required String text,
  }) = GdsSectionListItem;

  const factory GdsListItem.rightIcon({
    Key? key,
    required String text,
    String? subText,
    required GdsListItemState state,
    required VoidCallback onTap,
  }) = GdsRightIconListItem;

  const factory GdsListItem.optionCard({
    Key? key,
    required String text,
    GdsIcon? icon,
    required GdsListItemState state,
    required VoidCallback onTap,
  }) = GdsOptionCardListItem;

  const factory GdsListItem.icon({
    Key? key,
    required String text,
    GdsIcon? icon,
    required GdsListItemState state,
    required VoidCallback onTap,
  }) = GdsIconListItem;

  const factory GdsListItem.textLarge({
    Key? key,
    required String text,
    required GdsListItemState state,
    required bool isNegative,
    required VoidCallback onTap,
  }) = GdsTextListItem.large;

  const factory GdsListItem.textMedium({
    Key? key,
    required String text,
    required GdsListItemState state,
    required bool isNegative,
    required VoidCallback onTap,
  }) = GdsTextListItem.medium;

  const factory GdsListItem.pickerCard({
    Key? key,
    required String text,
    required GdsListItemState state,
    required VoidCallback onTap,
  }) = GdsPickerCardListItem;

  const factory GdsListItem.checkBox({
    Key? key,
    required String text,
    required GdsListItemState state,
    required VoidCallback onTap,
    EdgeInsets padding,
  }) = GdsControlListItem.checkbox;

  const factory GdsListItem.radio({
    Key? key,
    required String text,
    required GdsListItemState state,
    required VoidCallback onTap,
    EdgeInsets padding,
  }) = GdsControlListItem.radio;

  const factory GdsListItem.checkMark({
    Key? key,
    required String text,
    required GdsListItemState state,
    required VoidCallback onTap,
    EdgeInsets padding,
  }) = GdsControlListItem.checkmark;
}
