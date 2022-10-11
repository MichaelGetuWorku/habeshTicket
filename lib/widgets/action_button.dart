import 'package:flutter/material.dart';
import 'package:login/screen/profile%20setting/account_details.dart';

class ActionButton extends StatelessWidget {
  final String name;
  final IconData? icon;
  final VoidCallback? action;
  ActionButton({
    Key? key,
    this.icon,
    required this.name,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: action,
          //  () {
          // action!;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const AccountDetails(),
          //   ),
          // );
          // },
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade200,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Expanded(child: Container()),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
