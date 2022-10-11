import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/screen/otp_screen.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/fab.dart';

var phoneNumberController = TextEditingController();

class PhoneAuth extends StatefulWidget {
  PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FAB(),
      body: Column(
        children: [
          Gap(AppLayout.getHeight(40)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Phone Number auth',
              // textAlign: TextAlign.left,
              style: Styles.headLineStyle.copyWith(
                fontSize: AppLayout.getWidth(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 15,
            ),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('+251'),
                        ),
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(
                          phoneNumberController.text,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
