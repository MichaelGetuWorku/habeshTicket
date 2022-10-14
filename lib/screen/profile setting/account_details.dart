import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:login/screen/profile%20setting/balance.dart';
import 'package:login/screen/transfer_coin.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/fab.dart';
import 'package:login/utils/getImage.dart';
import 'package:login/widgets/action_button.dart';

var nameController = TextEditingController();

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance;
    FirebaseDatabase database = FirebaseDatabase.instance;
    final CollectionReference _user =
        FirebaseFirestore.instance.collection('Users');
    return Scaffold(
      floatingActionButton: const FAB(),
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Text(
                  'Account Details',
                  // textAlign: TextAlign.left,
                  style: Styles.headLineStyle.copyWith(
                    fontSize: AppLayout.getWidth(40),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(10)),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Edit Your Name',
                        hintText: 'Enter Name Here',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _user.doc(user.currentUser!.uid).set({
                        "name": nameController.text.trim(),
                      });
                      nameController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
              
              const SizedBox(
                height: 50,
              ),
              ActionButton(
                icon: Icons.attach_money,
                name: 'Check Balance',
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShowBalance(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ActionButton(
                icon: Icons.attach_money,
                name: 'Transfer Birr',
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransferCoin(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AccountDetails extends StatefulWidget {
//   AccountDetails({Key? key}) : super(key: key);

//   @override
//   State<AccountDetails> createState() => _AccountDetailsState();
// }

// class _AccountDetailsState extends State<AccountDetails> {
//   var user = FirebaseAuth.instance;
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   final CollectionReference _user =
//       FirebaseFirestore.instance.collection('Users');

//   //  void _changePassword(String currentPassword, String newPassword) {
//   //   final user = FirebaseAuth.instance.currentUser;
//   //   final cred = EmailAuthProvider.credential(
//   //     email: user!.email!,
//   //     password: currentPassword,
//   //   );

//   //   user.reauthenticateWithCredential(cred).then((value) {
//   //     user.updatePassword(newPassword).then((_) {
//   //       EmailAuthProvider.credential(
//   //         email: user.email!,
//   //         password: newPassword,
//   //       );
//   //       print('@@@@@@@@@@@@@@@@@@@@@@@@@');
//   //       print('SUCCSSESS');
//   //       print('@@@@@@@@@@@@@@@@@@@@@@@@@');
//   //     }).catchError((error) {
//   //       print(error);
//   //     });
//   //   }).catchError((err) {
//   //     print(err);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Account details"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//         child: Column(
//           children: [
//             Center(
//               child: Stack(
//                 children: [
//                   const CircleAvatar(
//                     backgroundColor: Colors.redAccent,
//                     maxRadius: 100,
//                   ),
//                   Positioned(
//                     top: 110,
//                     left: 150,
//                     // width: 250,
//                     // height: 250,
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.add_a_photo,
//                         size: 50,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Edit Your Name',
//                 hintText: 'Enter Name Here',
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ActionButton(icon: Icons.attach_money, name: 'Balance'),
//             ElevatedButton(
//               onPressed: () {
//                 _user.doc(user.currentUser!.uid).update({
//                   "name": nameController.text.trim(),
//                 });
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
