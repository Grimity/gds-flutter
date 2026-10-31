// Copyright © 2026 Grimity. All rights reserved.
// Licensed under the Grimity Source-Available License v1.0.
// AI/ML training and dataset use are prohibited. See LICENSE.

import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsButton.text]에 대한 프리뷰 위젯.
class GdsTextButtonPreview extends PreviewWidget {
  final typeControl = PreviewControl.select<GdsTextButtonType>(
    defaultValue: .solid,
    displayName: 'Type',
    values: GdsTextButtonType.values,
  );

  final variantControl = PreviewControl.select<GdsTextButtonVariant>(
    defaultValue: .primary,
    displayName: 'Variant',
    values: GdsTextButtonVariant.values,
  );

  final enabledControl = PreviewControl.boolean(
    defaultValue: true,
    displayName: 'Enabled',
  );

  final labelControl = PreviewControl.string(
    defaultValue: 'Label',
    displayName: 'Label',
  );

  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .lg,
    displayName: 'Size',
    values: const [.lg, .md, .sm],
  );

  final leadingIconControl = PreviewControl.select<GdsIcon>(
    displayName: 'Leading Icon',
    values: GdsIcon.values,
  );

  final trailingIconControl = PreviewControl.select<GdsIcon>(
    displayName: 'Trailing Icon',
    values: GdsIcon.values,
  );

  @override
  String get displayName => 'Text';

  @override
  List<String> get groups => ['Button'];

  @override
  Widget build(BuildContext context) {
    final type = typeControl.of(context);
    final variant = variantControl.of(context);
    final enabled = enabledControl.of(context);
    final label = labelControl.of(context);
    final size = sizeControl.of(context);
    final leadingIcon = leadingIconControl.of(context);
    final trailingIcon = trailingIconControl.of(context);

    return GdsButton.text(
      onTap: () => debugPrint('onTap() called'),
      type: type.value,
      variant: type.value.supportsVariant ? variant.value : null,
      enabled: enabled.value,
      label: label.value,
      size: size.value,
      leadingIcon: leadingIcon.mayBeValue,
      trailingIcon: trailingIcon.mayBeValue,
    );
  }
}
