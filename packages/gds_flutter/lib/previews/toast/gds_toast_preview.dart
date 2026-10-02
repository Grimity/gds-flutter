import 'package:flutter/widgets.dart';
import 'package:flutter_design_preview/flutter_design_preview.dart';
import 'package:gds_flutter/gds_flutter.dart';

/// [GdsToast]에 대한 프리뷰 위젯.
class GdsToastPreview extends PreviewWidget {
  final statusControl = PreviewControl.select<GdsToastStatus>(
    defaultValue: .none,
    displayName: 'Status',
    values: GdsToastStatus.values,
  );

  final messageControl = PreviewControl.string(
    defaultValue: '안내 메세지',
    displayName: 'Message',
  );

  @override
  String get displayName => 'Toast';

  @override
  List<String> get groups => ['Toast'];

  @override
  Widget build(BuildContext context) {
    final status = statusControl.of(context);
    final message = messageControl.of(context);

    return GdsToast(
      status: status.value,
      message: message.value,
    );
  }
}
