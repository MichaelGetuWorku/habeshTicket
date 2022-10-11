import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login/screen/forgot_password.dart';
import 'package:login/screen/signin_with_phone.dart';
import 'package:login/screen/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:login/utils/signin.dart';

import '../controller/auth_controller.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool loading = false;
  bool loading2 = false;

  final _formKey = GlobalKey<FormState>();

  void _showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: w,
              height: h * 0.2,
            ),
            Container(
              width: w,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Welcome back sign into your account",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(
                                  0.2,
                                ),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: const Icon(
                                Icons.email_rounded,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email address!';
                              }
                              bool emailValid = RegExp(
                                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Please enter a valid email address.";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(
                                  0.2,
                                ),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(
                                Icons.password,
                              ),
                              suffixIcon: InkWell(
                                onTap: _showPassword,
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password!';
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters!";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(30),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         blurRadius: 10,
                  //         spreadRadius: 7,
                  //         offset: const Offset(1, 1),
                  //         color: Colors.grey.withOpacity(
                  //           0.2,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   child: TextField(
                  //     controller: emailController,

                  //     // keyboardType: TextInputType.emailAddress,
                  //     decoration: InputDecoration(
                  //       hintText: "Email",
                  //       prefixIcon: const Icon(
                  //         Icons.email_rounded,
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(30),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         blurRadius: 10,
                  //         spreadRadius: 7,
                  //         offset: const Offset(1, 1),
                  //         color: Colors.grey.withOpacity(
                  //           0.2,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   child: TextField(
                  //     controller: passwordController,
                  //     obscureText: _obscureText,
                  //     decoration: InputDecoration(
                  //       hintText: "Password",
                  //       prefixIcon: const Icon(
                  //         Icons.password,
                  //       ),
                  //       suffixIcon: InkWell(
                  //         onTap: _showPassword,
                  //         child: Icon(
                  //           _obscureText
                  //               ? Icons.visibility
                  //               : Icons.visibility_off,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        const Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            loading
                ? Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Colors.red,
                      size: 50,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        return AuthController.instance.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.w400,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Sign in'),
                  ),
            SizedBox(height: h * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    emailController.clear();
                    passwordController.clear();
                    Get.to(() => SignUpPage());
                  },
                  child: const Text(
                    "Create account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "Continue in with",
              style: TextStyle(
                color: Colors.black26,
                fontSize: 16,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading2
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: Colors.red,
                          size: 50,
                        ),
                      )
                    : signin(
                        action: () {
                          setState(() {
                            loading2 = true;
                          });
                          AuthController.instance.sigInInWithGoogle();
                        },
                        imageUrl: "assets/images/g.png",
                      ),
                // signin(
                //   action: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => PhoneAuth(),
                //       ),
                //     );
                //   },
                //   // imageUrl: "img/f.png",
                //   icon: Icons.phone_sharp,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
