import 'package:flutter/material.dart';
import 'package:login/utils/app_layout.dart';

class Chips extends StatelessWidget {
  final String activeName;
  final String name;
  const Chips({
    Key? key,
    required this.activeName,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppLayout.getHeight(50),
          ),
          color: const Color(0xFFF4F6FD),
        ),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: size.width * 0.44,
              padding: EdgeInsets.symmetric(
                vertical: AppLayout.getHeight(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(
                    AppLayout.getHeight(50),
                  ),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Text(activeName),
              ),
            ),
            Container(
              width: size.width * 0.44,
              padding: EdgeInsets.symmetric(
                vertical: AppLayout.getHeight(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(
                    AppLayout.getHeight(50),
                  ),
                ),
                // color: Colors.grey.shade200,
              ),
              child: Center(
                child: Text(name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
