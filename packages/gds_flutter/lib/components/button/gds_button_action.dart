import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';
import 'package:gds_flutter/src/future_or_callback.dart';

/// 버튼에 대한 라벨과 동작을 정의하는 인터페이스.
class GdsTextButtonAction {
  const new({
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.layerLink,
    this._type,
    this._variant,
  });

  /// 팔로우 상태에 따라 적절한 버튼 유형, 레이블 및 동작을 반환.
  factory follow({
    required bool following,
    required FutureOrCallback onFollow,
    required FutureOrCallback onUnFollow,
  }) {
    return .new(
      type: following ? .outlined : .solid,
      label: following ? '언팔로우' : '팔로우',
      onTap: following ? onUnFollow : onFollow,
    );
  }

  final String label;
  final FutureOrCallback onTap;
  final bool enabled;
  final LayerLink? layerLink;
  final GdsTextButtonType? _type;
  final GdsTextButtonVariant? _variant;

  GdsTextButtonType get type {
    assert(_type != null, '부모가 [type]을 요구하므로 값을 명시적으로 지정해야 합니다.');
    return _type!;
  }

  GdsTextButtonVariant? get variant {
    assert(type.supportsVariant ? _variant != null : _variant == null);
    return _variant;
  }
}

/// 버튼에 대한 아이콘과 동작을 정의하는 인터페이스.
class GdsIconButtonAction {
  const new({
    required this.icon,
    required this.onTap,
    this.enabled = true,
    this.layerLink,
    this._type,
  });

  final GdsIcon icon;
  final FutureOrCallback onTap;
  final bool enabled;
  final LayerLink? layerLink;
  final GdsIconButtonType? _type;

  GdsIconButtonType get type {
    assert(_type != null, '부모가 [type]을 요구하므로 값을 명시적으로 지정해야 합니다.');
    return _type!;
  }
}
