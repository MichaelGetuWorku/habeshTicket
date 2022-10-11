import 'package:flutter/material.dart';

class TickContainer extends StatelessWidget {
  final bool? isColored;
  const TickContainer({Key? key, this.isColored}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   border: Border.all(
      //     width: 2.5,
      //     color: Colors.white,
      //   ),
      // ),
      child: const Icon(
        Icons.sports_soccer,
        color: Colors.white,
      ),
    );
  }
}
