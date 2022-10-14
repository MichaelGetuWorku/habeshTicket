import 'package:flutter/material.dart';
import 'package:login/utils/app_styles.dart';

class ErrorMessage extends StatelessWidget {
  final String mss;
  const ErrorMessage({
    Key? key,
    required this.mss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'Error Couldn\'t get $mss check your internet connection or contact our help and support',
          style: Styles.headLineStyle3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
