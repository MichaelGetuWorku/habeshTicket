import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:login/api/transfer.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/fab.dart';
import 'package:login/widgets/commonLayout.dart';
import 'package:quickalert/quickalert.dart';

var accountNumController = TextEditingController();
var balanceController = TextEditingController();

class TransferCoin extends StatelessWidget {
  const TransferCoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showDialog(data, error, errorMsg) {
      String dateNow = DateFormat("MMMM, dd, yyyy").format(
        DateTime.now(),
      );
      String timeNow = DateFormat("hh:mm:ss a").format(
        DateTime.now(),
      );
      error == true
          ? QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: errorMsg,
              onConfirmBtnTap: () {
                Navigator.of(context).pop();
              },
            )
          : QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: "Transfer Complete",
              text: "Congrats your Transfer was successful!",
              onConfirmBtnTap: () {
                FirebaseFirestore.instance.collection('CoinTransfer').add({
                  "userId": FirebaseAuth.instance.currentUser!.uid,
                  "amount": data[0].transaction.amount,
                  "fromAccNum": data[0].transaction.fromAccountNumber,
                  "toAccNum": data[0].transaction.toAccountNumber,
                  "date": dateNow,
                  "time": timeNow,
                });
                Navigator.of(context).pop();
              },
            );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     if (error != true) {
      //       FirebaseFirestore.instance.collection('CoinTransfer').add({
      //         "userId": FirebaseAuth.instance.currentUser!.uid,
      //         "amount": data.transaction.amount,
      //         "fromAccNum": data.transaction.fromAccountNumber,
      //         "toAccNum": data.transaction.toAccountNumber,
      //         "date": dateNow,
      //         "time": timeNow,
      //       });
      //     }
      //     return AlertDialog(
      //       title: error == true
      //           ? const Text("Error")
      //           : const Text('Transfer Complete'),
      //       content: error == true
      //           ? Text(errorMsg)
      //           : const Text('Congrats your Transfer was successful!'),
      //       actions: [
      //         TextButton(
      //           child: const Text('Ok'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      floatingActionButton: const FAB(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(AppLayout.getHeight(40)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Transfer Birr',
                  // textAlign: TextAlign.left,
                  style: Styles.headLineStyle.copyWith(
                    fontSize: AppLayout.getWidth(40),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(10)),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 15,
                ),
                child: TextField(
                  controller: accountNumController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account Number',
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(10)),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 15,
                ),
                child: TextField(
                  controller: balanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Birr amount',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 15,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      var res = await transferCoin(
                        accountNumController.text,
                        balanceController.text,
                      );
                      _showDialog(
                        res.data,
                        res.error,
                        res.errorMsg,
                      );
                      accountNumController.clear();
                      balanceController.clear();
                    },
                    child: const Text(
                      'Transfer',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('CoinTransfer')
                    .where(
                      'userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = $snapshot.error');
                  }
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    if (docs.isNotEmpty) {
                      return ListView.builder(
                        physics: const ScrollPhysics(
                          parent: NeverScrollableScrollPhysics(),
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(21),
                                  bottomRight: Radius.circular(21),
                                  topLeft: Radius.circular(21),
                                  topRight: Radius.circular(21),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ]),
                            child: Column(
                              children: [
                                CommonLayout(
                                  mainName: 'Date',
                                  secondaryName: data['date'],
                                  number: 'Amount',
                                  secondaryNum: '${data['amount']} Birr',
                                  isTop: true,
                                ),
                                CommonLayout(
                                  mainName: 'From',
                                  secondaryName: data['fromAccNum'],
                                  number: 'To',
                                  secondaryNum: data['toAccNum'],
                                ),
                                const Gap(20),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Wow Such Empty ☹'),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
