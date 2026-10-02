import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTextField.search]에 대한 프리뷰 위젯.
class GdsSearchTextFieldPreview extends PreviewWidget {
  final sizeControl = PreviewControl.select<GdsSize>(
    defaultValue: .md,
    displayName: 'Size',
    values: const [.md, .sm],
  );

  final placeholderControl = PreviewControl.string(
    initialValue: 'Search',
    displayName: 'Placeholder',
  );

  @override
  String get displayName => 'Text Field · Search';

  @override
  List<String> get groups => ['Input'];

  @override
  Widget build(BuildContext context) {
    final size = sizeControl.of(context);
    final placeholder = placeholderControl.of(context);

    return GdsTextField.search(
      size: size.value,
      placeholder: placeholder.mayBeValue,
    );
  }
}
