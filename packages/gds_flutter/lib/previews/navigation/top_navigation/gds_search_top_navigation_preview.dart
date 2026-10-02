import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsTopNavigation.search]에 대한 프리뷰 위젯.
class GdsSearchTopNavigationPreview extends PreviewWidget {
  final placeholderControl = PreviewControl.string(
    initialValue: 'Search',
    displayName: 'Placeholder',
  );

  final initialTextControl = PreviewControl.string(
    initialValue: '',
    displayName: 'Initial Text',
  );

  @override
  String get displayName => 'Search';

  @override
  List<String> get groups => ['Navigation', 'Top Navigation'];

  @override
  Widget build(BuildContext context) {
    final placeholder = placeholderControl.of(context);
    final initialText = initialTextControl.of(context);

    return GdsTopNavigation.search(
      key: ValueKey(initialText.mayBeValue),
      onBack: () => debugPrint('onBack() called'),
      placeholder: placeholder.mayBeValue,
      initialText: initialText.mayBeValue,
      onSubmitted: (value) => debugPrint('onSubmitted($value) called'),
      onComplete: () => debugPrint('onComplete() called'),
      onChanged: (value) => debugPrint('onChanged($value) called'),
    );
  }
}
