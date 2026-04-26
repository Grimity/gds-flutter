import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_refresh_indicator/flutter_refresh_indicator.dart';
import 'package:gds_components/gds_components.dart';
import 'package:gds_foundation/gds_foundation.dart';

class GdsRefresh extends StatelessWidget {
  const GdsRefresh({
    super.key,
    required this.onRefresh,
    this.onError,
    required this.child,
  });

  final AsyncCallback onRefresh;
  final ErrorCallback? onError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.gdsColors;

    return Theme(
      data: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: colors.surface.inverse, // foregroundColor
            refreshBackgroundColor: colors.surface.base, // backgroundColor
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async => await onRefresh().onError((error, stackTrace) {
          if (error != null) {
            onError?.call(error, stackTrace);
          }

          // 에러 발생 시에 별도의 토스트 메세지 표시
          if (context.mounted) {
            GdsToast.open(context, type: GdsToastType.nagative, message: '새로 고침할 수 없음');
          }
        }),
        child: child,
      ),
    );
  }
}
