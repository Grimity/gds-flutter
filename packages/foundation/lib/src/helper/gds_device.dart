import 'package:flutter/widgets.dart';

import '../gds_screen.dart';

enum GdsDeviceType {
  mobile,
  tablet,
}

extension GdsDevice on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  GdsDeviceType get gdsDeviceType =>
      screenWidth >= GdsScreen.tableMinWidth ? GdsDeviceType.tablet : GdsDeviceType.mobile;

  bool get isTablet => gdsDeviceType == GdsDeviceType.tablet;
  bool get isMobile => gdsDeviceType == GdsDeviceType.mobile;
}
