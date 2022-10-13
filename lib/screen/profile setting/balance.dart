import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login/api/get_ledger.dart';
import 'package:login/api/get_tickets.dart';
import 'package:login/api/get_transaction.dart';
import 'package:login/model/get_ledger.dart';
import 'package:login/model/get_tickets.dart';
import 'package:login/model/get_transactions.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/fab.dart';

import '../../widgets/commonLayout.dart';

class ShowBalance extends StatefulWidget {
  const ShowBalance({Key? key}) : super(key: key);

  @override
  State<ShowBalance> createState() => _ShowBalanceState();
}

class _ShowBalanceState extends State<ShowBalance> {
  late Future<GetLedger> futureLedgers;
  @override
  void initState() {
    super.initState();
    futureLedgers = getLedger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FAB(),
      backgroundColor: Styles.bgColor,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(AppLayout.getHeight(40)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'Check balance',
                    // textAlign: TextAlign.left,
                    style: Styles.headLineStyle.copyWith(
                      fontSize: AppLayout.getWidth(40),
                    ),
                  ),
                ),
                // Gap(AppLayout.getHeight(10)),
                FutureBuilder<GetLedger>(
                  future: getLedger(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var accountNo = snapshot.data!.data.ledger.accountNo;
                      var balance = snapshot.data!.data.ledger.balance;
                      return _balance(
                        balance: balance,
                        accountNo: accountNo,
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Error on getting your balance!');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const Gap(40),
                const Center(
                  child: Text(
                    'To recharge your balance please contact our Merchant!',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FutureBuilder<GetTransactions>(
                  future: getTransactions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var transactions =
                          snapshot.data!.data.transactions.length;
                      return ListView.builder(
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: transactions,
                        itemBuilder: ((context, index) {
                          var amount =
                              snapshot.data!.data.transactions[index].amount;
                          var type =
                              snapshot.data!.data.transactions[index].type;
                          var to = snapshot
                              .data!.data.transactions[index].toAccountNumber;
                          var from = snapshot
                              .data!.data.transactions[index].fromAccountNumber;
                          var time =
                              snapshot.data!.data.transactions[index].timestamp;
                          var date =
                              DateTime.fromMicrosecondsSinceEpoch(time * 1000);
                          var h = date.hour;
                          var m = date.minute;
                          String timeStamp = "$h:$m";
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
                                  mainName: 'Amount',
                                  secondaryName: '${amount.toString()} Birr',
                                  number: 'Type',
                                  secondaryNum: type.toUpperCase(),
                                ),
                                CommonLayout(
                                  mainName: 'From',
                                  secondaryName: from,
                                  number: 'To',
                                  secondaryNum: to,
                                ),
                                CommonLayout(
                                  mainName: 'Time',
                                  secondaryName: timeStamp,
                                  number: 'Status',
                                  secondaryNum: 'Received',
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Error on getting your Transaction!');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    Future<GetLedger> futureLedger = getLedger();
    setState(() {
      futureLedgers = Future.value(futureLedger);
    });
  }
}

class _balance extends StatelessWidget {
  const _balance({
    Key? key,
    required this.balance,
    required this.accountNo,
  }) : super(key: key);

  final double balance;
  final String accountNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Gap(AppLayout.getHeight(40)),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
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
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$$balance',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Account Number: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        accountNo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
