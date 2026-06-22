import 'package:flutter/material.dart';

class Responsive {
  static late double _screenWidth;
  static late double _screenHeight;

  //===========>>> Initialize with BuildContext
  static void init(BuildContext context) {
    _screenWidth = MediaQuery.sizeOf(context).width;
    _screenHeight = MediaQuery.sizeOf(context).height;
  }

  //===========>>> Get responsive font size
  static double fontSize(double size) {
    // Base scaling logic
    double scale = _screenWidth / 1440; // Desktop base
    if (_screenWidth < 1024) scale = _screenWidth / 768; // Tablet base
    if (_screenWidth < 600) scale = _screenWidth / 375; // Mobile base

    // Clamp to prevent extreme sizes on very large or small screens
    scale = scale.clamp(0.7, 1.1);
    return size * scale;
  }

  //===========>>> Get responsive heights/widths
  static double height(double value) =>
      value * (_screenHeight / 900).clamp(0.8, 1.2);
  static double width(double value) =>
      value * (_screenWidth / 1440).clamp(0.8, 1.2);

  // Helper methods
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;
}
