import 'package:flutter/material.dart';

class signin extends StatelessWidget {
  final VoidCallback action;
  final String? imageUrl;
  final IconData? icon;
  const signin({
    Key? key,
    this.imageUrl,
    required this.action,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: action,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: const Color.fromARGB(
            255,
            218,
            215,
            215,
          ),
          child: imageUrl != null
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    imageUrl!,
                  ),
                )
              : CircleAvatar(
                  radius: 25,
                  child: Icon(icon),
                ),
        ),
      ),
    );
  }
}
