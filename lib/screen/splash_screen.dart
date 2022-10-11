import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.maxFinite,
      // height: double.maxFinite,
      color: Colors.white,
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.red,
          size: 50,
        ),
      ),
    );
  }
}
