import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.grey.shade200,
      label: const Text(
        'Back',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
