import 'package:flutter/widgets.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 버튼에 대한 라벨과 동작을 정의하는 인터페이스.
class GdsTextButtonAction {
  const GdsTextButtonAction({
    required this.label,
    required this.onTap,
    this._type,
    this._variant,
  });

  final String label;
  final VoidCallback onTap;
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
  const GdsIconButtonAction({
    required this.icon,
    required this.onTap,
    this._type,
  });

  final GdsIcon icon;
  final VoidCallback onTap;
  final GdsIconButtonType? _type;

  GdsIconButtonType get type {
    assert(_type != null, '부모가 [type]을 요구하므로 값을 명시적으로 지정해야 합니다.');
    return _type!;
  }
}
