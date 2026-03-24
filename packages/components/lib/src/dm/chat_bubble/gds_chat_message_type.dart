part of '../gds_chat_bubble.dart';

enum GdsChatMessageType {
  me,
  other;

  Color textColor(GdsSemanticColor colors) => switch (this) {
    GdsChatMessageType.me => colors.text.white,
    GdsChatMessageType.other => colors.text.grayBold,
  };

  Color backgroundColor(GdsSemanticColor colors) => switch (this) {
    GdsChatMessageType.me => colors.surface.primaryNormal,
    GdsChatMessageType.other => colors.surface.graySubtler,
  };

  BorderRadius get borderRadius => switch (this) {
    GdsChatMessageType.me => BorderRadius.only(
      topLeft: Radius.circular(GdsAtomicRadius.xl),
      topRight: Radius.circular(GdsAtomicRadius.xl),
      bottomRight: Radius.circular(GdsAtomicRadius.xs),
      bottomLeft: Radius.circular(GdsAtomicRadius.xl),
    ),
    GdsChatMessageType.other => BorderRadius.only(
      topLeft: Radius.circular(GdsAtomicRadius.xl),
      topRight: Radius.circular(GdsAtomicRadius.xl),
      bottomRight: Radius.circular(GdsAtomicRadius.xl),
      bottomLeft: Radius.circular(GdsAtomicRadius.xs),
    ),
  };

  EdgeInsets margin(BuildContext context) {
    final horizontalInset = context.isTablet ? GdsSpacing.spacing72 : GdsSpacing.spacing20;

    return switch (this) {
      GdsChatMessageType.me => EdgeInsets.only(left: horizontalInset),
      GdsChatMessageType.other => EdgeInsets.only(right: horizontalInset),
    };
  }

  Alignment get alignment => switch (this) {
    GdsChatMessageType.me => Alignment.centerRight,
    GdsChatMessageType.other => Alignment.centerLeft,
  };

  CrossAxisAlignment get crossAxisAlignment => switch (this) {
    GdsChatMessageType.me => CrossAxisAlignment.end,
    GdsChatMessageType.other => CrossAxisAlignment.start,
  };
}
