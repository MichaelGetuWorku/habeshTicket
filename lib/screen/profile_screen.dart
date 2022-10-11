import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login/controller/auth_controller.dart';
import 'package:login/screen/gift_screen.dart';
import 'package:login/screen/profile%20setting/account_details.dart';
import 'package:login/screen/purchase_history.dart';
import 'package:login/widgets/action_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final CollectionReference _user =
        FirebaseFirestore.instance.collection('Users');
    var user = FirebaseAuth.instance;
    var hight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    maxRadius: 100,
                    child: Icon(
                      Icons.settings,
                      size: 200,
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user.currentUser!.uid)
                        .snapshots(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot,
                    ) {
                      // if (snapshot.connectionState != ConnectionState.none) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text('Enter your name');
                      }
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!['name'].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const Text('Enter your name');
                      }
                      // }
                      // else {
                      //   return Text('Connection state: ${snapshot.error}');
                      // }
                    },
                  ),
                  Text(
                    user.currentUser!.email.toString(),
                    style: const TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ActionButton(
              name: 'Account Details',
              icon: Icons.privacy_tip,
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountDetails(),
                  ),
                );
              },
            ),
            ActionButton(
                name: 'Purchase History',
                icon: Icons.history,
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PurchaseHistoryScreen(),
                    ),
                  );
                }),
            ActionButton(
              name: 'Gift History',
              icon: Icons.card_giftcard,
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GiftScreen(),
                  ),
                );
              },
            ),
            loading
                ? Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Colors.red,
                      // leftDotColor: const Color(0xFF1A1A3F),
                      // rightDotColor: const Color(0xFFEA3799),
                      size: 50,
                    ),
                  )
                : ActionButton(
                    name: 'Logout',
                    icon: Icons.logout_outlined,
                    action: () {
                      AuthController.instance.logOut();
                      setState(() {
                        loading = true;
                      });
                    }),
            // ActionButton(
            //   name: 'Privacy',
            //   icon: Icons.privacy_tip,
            // ),
            // ActionButton(
            //   name: 'Privacy',
            //   icon: Icons.privacy_tip,
            // ),
          ],
        ),
      ),
    );
  }
}
