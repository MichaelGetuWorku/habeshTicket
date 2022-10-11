// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/api/login.dart';
import 'package:login/model/login.dart';
import 'package:login/screen/bottom_bar.dart';
import 'package:login/screen/login_page.dart';

class AuthController extends GetxController {
  // the AuthController will be globally available
  static AuthController instance = Get.find();
  // Firebase user Model init
  // coming from FB will include email and password ...
  late Rx<User?> user;
  late String firebaseIdToken;
  late String jwt;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('Users');
  var users = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    // what ever happened to the user the app will be notified like log in or log out
    user.bindStream(auth.userChanges());
    ever(
      user,
      _initialScreen,
    ); // Called every time SMT changes it will notify us.
  }

  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const BottomBar();
        } else {
          return LoginPage();
        }
      }),
    );
  }

  _initialScreen(User? user) async {
    if (user == null) {
      print('login Page');
      // If there is no user the app will redirect to the login page
      Get.offAll(
        () => LoginPage(),
      );
    } else {
      // getting the firebase id token.
      await user.getIdToken().then(
            (value) => firebaseIdToken = value,
            // Currently i am manually sending the request to the backend on postmen.
          );
      // If the user is already logged in Home page is disabled
      // print(firebaseIdToken);
      var smt = await loginApi(firebaseIdToken);
      print('!!!!!!!!!!!!!!!!jwt!!!!!!!!!!!!!!!!!!!!!!!!!');
      jwt = smt.data.jwt;
      print(jwt);
      return Get.offAll(
        () => const BottomBar(),
      );
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        "About User",
        "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account creation failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Login failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  sigInInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void logOut() async {
    await auth.signOut();
  }

  Future resetPassword(email, context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "About Password Reset",
        "Password Reset Email Sent",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
      // hiding the loding indicatior
      Navigator.of(context).pop();
    } catch (e) {
      Get.snackbar(
        "About Password Reset",
        "Password Reset message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Password Reset failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
      Navigator.of(context).pop();
    }
    // Utils.showSnackBar('Password Reset Email Sent');
  }

  String? verificationCode;
  void verifyPhone(phone, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+251$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(credential.smsCode);
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verificationID, int? resendToken) {
          print(verificationID);
          verificationCode = verificationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          verificationCode = verificationID;
        },
        timeout: const Duration(seconds: 120));
  }
}
