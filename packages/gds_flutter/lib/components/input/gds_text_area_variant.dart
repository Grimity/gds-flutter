import 'package:gds_flutter/components/input/gds_input_decoration.dart';
import 'package:gds_flutter/components/input/gds_input_style.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// 텍스트 영역의 크기와 시각적 스타일을 나타내는 열거형.
enum GdsTextAreaVariant {
  normal(
    height: 150,
    enabled: _enabledStyle,
    filled: _filledStyle,
    focused: _focusedStyle,
    error: _errorStyle,
    success: _successStyle,
    disabled: _disabledStyle,
    decoration: .new(
      typography: .label2,
      spacing: 4,
      border: .all(),
      radius: .sm,
      padding: .only(top: 16, left: 16, right: 16, bottom: 12),
    ),
  ),
  underline(
    height: 240,
    enabled: _enabledStyle,
    filled: _filledStyle,
    focused: _focusedStyle,
    error: _errorStyle,
    success: _successStyle,
    disabled: _disabledStyle,
    decoration: .new(
      typography: .label2,
      spacing: 4,
      border: .new(bottom: 1),
      padding: .only(top: 16, left: 16, right: 16, bottom: 12),
    ),
  ),
  text(
    height: 240,
    enabled: _enabledStyle,
    filled: _filledStyle,
    focused: _focusedStyle,
    error: _errorStyle,
    success: _successStyle,
    disabled: _disabledStyle,
    decoration: .new(
      typography: .label2,
      spacing: 4,
      padding: .only(top: 16, bottom: 12),
    ),
  ),
  sm(
    height: 100,
    enabled: _enabledStyle,
    filled: _filledStyle,
    focused: _focusedStyle,
    error: _errorStyle,
    success: _successStyle,
    disabled: _disabledStyle,
    decoration: .new(
      typography: .label2,
      spacing: 2,
      border: .all(width: 1),
      radius: .sm,
      padding: .symmetric(vertical: 10, horizontal: 16),
    ),
  );

  const GdsTextAreaVariant({
    required this.height,
    required this.enabled,
    required this.filled,
    required this.focused,
    required this.error,
    required this.success,
    required this.disabled,
    required this.decoration,
  });

  final double height;
  final GdsInputStyle enabled;
  final GdsInputStyle filled;
  final GdsInputStyle focused;
  final GdsInputStyle error;
  final GdsInputStyle success;
  final GdsInputStyle disabled;
  final GdsInputDecoration decoration;

  static const _enabledStyle = GdsInputStyle(
    borderColor: .borderGraySubtle,
    textColor: .textGraySubtle,
  );

  static const _filledStyle = GdsInputStyle(
    borderColor: .borderGraySubtle,
    textColor: .textGrayBold,
  );

  static const _focusedStyle = GdsInputStyle(
    borderColor: .borderGraySubtle,
    textColor: .textGrayBold,
  );

  static const _errorStyle = GdsInputStyle(
    backgroundColor: .statusNegative,
    backgroundOpacity: GdsOpacity.opacity10,
    borderColor: .statusNegative,
    textColor: .textGrayBold,
  );

  static const _successStyle = GdsInputStyle(
    borderColor: .statusPositive,
    textColor: .textGrayBold,
  );

  static const _disabledStyle = GdsInputStyle(
    backgroundColor: .surfaceGraySubtlest,
    borderColor: .borderGraySubtler,
    textColor: .textGraySubtler,
  );
}
