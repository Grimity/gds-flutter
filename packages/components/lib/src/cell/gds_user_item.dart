import 'package:flutter/widgets.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

part 'user_item/profile/gds_profile_frame.dart';
part 'user_item/profile/gds_default_user_item.dart';
part 'user_item/profile/gds_id_user_item.dart';
part 'user_item/profile/gds_icon_id_user_item.dart';
part 'user_item/profile/gds_radio_user_item.dart';
part 'user_item/profile/gds_follow_user_item.dart';
part 'user_item/notification/gds_notification_user_item.dart';
part 'user_item/link/gds_link_user_item.dart';
part 'user_item/link/gds_link_main_user_item.dart';

abstract class GdsUserItem extends StatelessWidget {
  const GdsUserItem({super.key});

  const factory GdsUserItem.defaultType({
    Key? key,
    required String nickName,
    required GdsPersonAvatar personAvatar,
    GdsOutlinedButton? primaryActionButton,
    GdsOutlinedButton? secondaryActionButton,
  }) = GdsDefaultUserItem;

  const factory GdsUserItem.id({
    Key? key,
    required String nickName,
    required GdsPersonAvatar personAvatar,
    required String userId,
    GdsOutlinedButton? primaryActionButton,
    GdsOutlinedButton? secondaryActionButton,
  }) = GdsIdUserItem;

  const factory GdsUserItem.iconId({
    Key? key,
    required String nickName,
    required GdsPersonAvatar personAvatar,
    required String userId,
    GdsIconButton? primaryActionButton,
    GdsIconButton? secondaryActionButton,
  }) = GdsIconIdUserItem;

  const factory GdsUserItem.radio({
    Key? key,
    required String nickName,
    required GdsPersonAvatar personAvatar,
    required String userId,
    required GdsRadioButton radioButton,
  }) = GdsRadioUserItem;

  const factory GdsUserItem.follow({
    Key? key,
    required String nickName,
    required GdsPersonAvatar personAvatar,
    required GdsFollowUserInfo followUserInfo,
    GdsOutlinedButton? primaryActionButton,
    GdsOutlinedButton? secondaryActionButton,
  }) = GdsFollowUserItem;

  const factory GdsUserItem.notification({
    Key? key,
    required String titleText,
    required String messageText,
    required String timeText,
    VoidCallback? onTap,
    required GdsIconButton iconButton,
  }) = GdsNotificationUserItem;

  const factory GdsUserItem.link({
    Key? key,
    required GdsIcon icon,
    required String siteText,
    required String linkText,
  }) = GdsLinkUserItem;

  const factory GdsUserItem.linkMain({
    Key? key,
    required GdsIcon icon,
    required String siteText,
  }) = GdsLinkMainUserItem;
}
