// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:gds_flutter/components/button/gds_button_decoration.dart';
import 'package:gds_flutter/components/button/gds_button_style.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/future_or_callback.dart';
import 'package:pervice/pervice.dart';

/// 상태와 크기에 맞는 스타일 및 배치를 적용하는 버튼의 기본 프레임.
class GdsButtonFrame extends StatelessWidget {
  const new({
    super.key,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.loadingStyle,
    required this.decoration,
    required this.enabled,
    required this.onTap,
    required this.label,
    required this.mainAxisSize,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  final GdsButtonStyle enabledStyle;
  final GdsButtonStyle disabledStyle;
  final GdsButtonStyle loadingStyle;
  final GdsButtonDecoration decoration;
  final bool enabled;
  final FutureOrCallback? onTap;
  final String? label;
  final MainAxisSize? mainAxisSize;
  final GdsIcon? leadingIcon;
  final GdsIcon? trailingIcon;

  /// 라벨과 아이콘 구성으로 결정된 버튼의 레이아웃 유형.
  GdsButtonType get type {
    if (label == null) return .iconOnly;
    if (leadingIcon != null) return .leadingIcon;
    if (trailingIcon != null) return .trailingIcon;

    return .textOnly;
  }

  /// 현재 아이콘의 크기.
  double get iconSize => decoration.iconSize;

  /// 현재 라벨의 타이포그래피.
  GdsTypography get typography => decoration.typography;

  @override
  Widget build(BuildContext context) {
    assert(label != null || leadingIcon != null || trailingIcon != null);
    assert(leadingIcon == null || trailingIcon == null);

    // 비동기 콜백 실행 중 로딩 상태 관리.
    final loading = context.stateOf(() => false);

    final style = loading() ? loadingStyle : (enabled ? enabledStyle : disabledStyle);
    final borderColor = style.borderColor ?? .transparent;
    final textColor = style.textColor ?? .transparent;
    final iconColor = style.iconColor ?? .transparent;

    return IgnorePointer(
      ignoring: !enabled || loading(),
      child: GdsGesture(
        onTap: onTap == null ? null : () => onTap!.run(loading),
        child: GdsContainer(
          animation: .fast,
          padding: decoration.of(type),
          color: style.backgroundColor,
          radius: decoration.radius,
          border: .all(
            width: 1,
            color: borderColor,
          ),
          width: type == .iconOnly ? decoration.size.value : null,
          height: decoration.size != .none ? decoration.size.value : null,
          child: Stack(
            alignment: .center,
            children: [
              Row(
                mainAxisAlignment: .center,
                mainAxisSize: mainAxisSize ?? .min,
                spacing: decoration.spacing,
                children: [
                  // 왼쪽 아이콘 표시.
                  if (leadingIcon != null) ...[
                    leadingIcon!.build(size: iconSize, color: iconColor),
                  ],

                  // 텍스트 표시.
                  if (label != null) ...[
                    GdsText(
                      label!,
                      color: textColor,
                      style: typography,
                    ),
                  ],

                  // 오른쪽 아이콘 표시.
                  if (trailingIcon != null) ...[
                    trailingIcon!.build(size: iconSize, color: iconColor),
                  ],
                ],
              ),

              // 로딩 상태일 때 인디케이터 표시.
              Positioned.fill(
                child: Center(
                  child: GdsTransition.crossFade(
                    value: loading(),
                    child: loading() ? GdsCircularLoading(size: iconSize) : SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
