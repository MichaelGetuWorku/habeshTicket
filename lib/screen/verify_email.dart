import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/controller/auth_controller.dart';
import 'package:login/screen/bottom_bar.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/fab.dart';

class VerifyEmail extends StatefulWidget {
  VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const BottomBar()
      : Scaffold(
          backgroundColor: Styles.bgColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(AppLayout.getHeight(40)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Verify Your Email',
                  // textAlign: TextAlign.left,
                  style: Styles.headLineStyle.copyWith(
                    fontSize: AppLayout.getWidth(40),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Verification Email has been sent to your address',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // ElevatedButton.icon(
                      //   style: ElevatedButton.styleFrom(
                      //     minimumSize: const Size.fromHeight(50),
                      //   ),
                      //   onPressed: canResendEmail ? sendVerificationEmail : null,
                      //   icon: const Icon(Icons.email),
                      //   label: const Text('Resent Email'),
                      // ),
                      // TextButton(
                      //   onPressed: () => FirebaseAuth.instance.signOut(),
                      //   child: const Text('Cancel'),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
