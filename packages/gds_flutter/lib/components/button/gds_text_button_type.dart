import 'package:gds_flutter/components/button/gds_button_decoration.dart';
import 'package:gds_flutter/components/button/gds_button_style.dart';

/// 텍스트 버튼의 시각적 스타일을 나타내는 열거형.
enum GdsTextButtonVariant {
  primary,
  assistive,
}

/// 텍스트 버튼의 시각적 스타일을 나타내는 열거형.
enum GdsTextButtonType {
  /// 배경색이 채워진 형태의 버튼으로, 강조해야 할 주요 액션에 사용.
  solid(
    none: (
      enabled: .new(
        backgroundColor: .surfaceInverse,
        textColor: .textInverse,
        iconColor: .iconInverse,
      ),
      disabled: .new(
        backgroundColor: .surfaceGraySubtlest,
        textColor: .textGraySubtler,
        iconColor: .iconGraySubtler,
      ),
      loading: .new(
        backgroundColor: .surfaceGraySubtler,
      ),
    ),
    lgDecoration: _lgDecoration,
    mdDecoration: _mdDecoration,
    smDecoration: _smDecoration,
  ),

  /// 버튼의 테두리만 채워진 형태로, 상대적으로 덜 강조해야 할 액션에 사용.
  outlined(
    none: (
      enabled: .new(
        textColor: .textGrayBold,
        iconColor: .iconGrayBold,
        borderColor: .borderGraySubtle,
      ),
      disabled: .new(
        textColor: .textGraySubtler,
        iconColor: .iconGraySubtler,
        borderColor: .borderGraySubtler,
      ),
      loading: .new(
        borderColor: .borderGrayNormal,
      ),
    ),
    lgDecoration: _lgDecoration,
    mdDecoration: _mdDecoration,
    smDecoration: _smDecoration,
  ),

  /// 배경색이나 테두리가 없는 버튼으로, 주로 강조가 덜한 보조적인 액션에 사용
  borderless(
    primary: (
      enabled: .new(
        textColor: .textPrimaryNormal,
        iconColor: .iconPrimaryNormal,
      ),
      disabled: .new(
        textColor: .textGraySubtler,
        iconColor: .iconGraySubtler,
      ),
      loading: .new(),
    ),
    assistive: (
      enabled: .new(
        textColor: .textGraySubtle,
        iconColor: .iconGraySubtle,
      ),
      disabled: .new(
        textColor: .textGraySubtler,
        iconColor: .iconGraySubtler,
      ),
      loading: .new(),
    ),
    lgDecoration: .new(
      textOnly: .symmetric(vertical: 6),
      leadingIcon: .symmetric(vertical: 6),
      trailingIcon: .symmetric(vertical: 6),
      typography: .label1,
      iconSize: 24,
      spacing: 6,
      radius: .xs,
      size: .sm,
    ),
    mdDecoration: .new(
      textOnly: .zero,
      leadingIcon: .zero,
      trailingIcon: .zero,
      typography: .label3,
      iconSize: 20,
      spacing: 6,
      radius: .xs,
      size: .none,
    ),
    smDecoration: .new(
      textOnly: .zero,
      leadingIcon: .zero,
      trailingIcon: .zero,
      typography: .label3,
      iconSize: 16,
      spacing: 4,
      radius: .xs,
      size: .none,
    ),
  );

  const new({
    this.none,
    this.primary,
    this.assistive,
    required this.lgDecoration,
    required this.mdDecoration,
    required this.smDecoration,
  });

  final GdsButtonStyleSet? none;
  final GdsButtonStyleSet? primary;
  final GdsButtonStyleSet? assistive;
  final GdsButtonDecoration lgDecoration;
  final GdsButtonDecoration mdDecoration;
  final GdsButtonDecoration smDecoration;

  /// 버튼 유형이 변형 스타일을 지원하는지 여부.
  bool get supportsVariant {
    return primary != null || assistive != null;
  }
}

const _lgDecoration = GdsButtonDecoration(
  textOnly: .symmetric(horizontal: 20),
  leadingIcon: .only(left: 16, right: 20),
  trailingIcon: .only(left: 20, right: 16),
  typography: .label1,
  iconSize: 24,
  spacing: 6,
  radius: .sm,
  size: .lg,
);

const _mdDecoration = GdsButtonDecoration(
  textOnly: .symmetric(horizontal: 16),
  leadingIcon: .only(left: 12, right: 16),
  trailingIcon: .only(left: 16, right: 12),
  typography: .label3,
  iconSize: 20,
  spacing: 6,
  radius: .sm,
  size: .md,
);

const _smDecoration = GdsButtonDecoration(
  textOnly: .symmetric(horizontal: 12),
  leadingIcon: .only(left: 10, right: 12),
  trailingIcon: .only(left: 12, right: 10),
  typography: .label3,
  iconSize: 16,
  spacing: 4,
  radius: .sm,
  size: .sm,
);
