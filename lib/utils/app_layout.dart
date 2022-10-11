import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// It returns the height of the screen in pixels
  /// Returns:
  ///   The height of the screen.
  static getScreenHeight() {
    return Get.height;
  }

  static getScreenWidth() {
    return Get.width;
  }

  static getHeight(double pixels) {
    /// `getHeight` takes a double value and returns a double value
    /// Args:
    ///   pixels (double): The amount of pixels you want to convert to.
    /// Returns:
    ///   The height of the screen in pixels.
    double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static getWidth(double pixels) {
    double x = getScreenWidth() / pixels;
    return getScreenWidth() / x;
  }
}
