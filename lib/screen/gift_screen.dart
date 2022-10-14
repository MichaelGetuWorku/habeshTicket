// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:login/api/get_transfered_tickets.dart';
import 'package:login/model/get_transfered_tickets.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/error_message.dart';
import 'package:login/utils/fab.dart';
import 'package:login/utils/loading_widet.dart';
import 'package:login/widgets/commonLayout.dart';

var accountNumController = TextEditingController();

class GiftScreen extends StatelessWidget {
  const GiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FAB(),
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
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
                  'Transferred Tickets',
                  style: Styles.headLineStyle.copyWith(
                    fontSize: AppLayout.getWidth(35),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(10)),
              FutureBuilder<GetTransferredTicket>(
                future: getTransferredTickets(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.data.transactions;
                    if (data.isNotEmpty) {
                      return ListView.builder(
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, index) {
                          var fromAccountNo = snapshot
                              .data!.data.transactions[index].fromAccountNo;
                          var timeStamp =
                              snapshot.data!.data.transactions[index].timestamp;
                          var date = DateTime.fromMicrosecondsSinceEpoch(
                              timeStamp * 1000);
                          String formattedTime =
                              DateFormat('hh:mm').format(date);

                          var toAccountNo = snapshot
                              .data!.data.transactions[index].toAccountNo;
                          var type =
                              snapshot.data!.data.transactions[index].type;
                          var stadiumName =
                              snapshot.data!.data.transactions[index];

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
                                  mainName: 'From',
                                  secondaryName: fromAccountNo,
                                  number: 'Type',
                                  secondaryNum: type.toUpperCase(),
                                  isTop: true,
                                ),
                                CommonLayout(
                                  mainName: 'To Account No',
                                  secondaryName: toAccountNo,
                                  number: 'Time',
                                  secondaryNum: formattedTime,
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
                  } else if (snapshot.hasError) {
                    return const ErrorMessage(
                      mss: 'your Gift History',
                    );
                  }
                  return const LoadingWidget();
                },
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
