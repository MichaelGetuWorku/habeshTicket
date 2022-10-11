// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:login/api/get_tickets.dart';
import 'package:login/api/transfer_ticket.dart';
import 'package:login/model/get_desc_event.dart';
import 'package:login/model/get_tickets.dart';
import 'package:login/screen/generate_qr.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/widgets/chips.dart';
import 'package:login/widgets/commonLayout.dart';
import 'package:login/widgets/ticket_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var accountNumController = TextEditingController();

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showDialog(
      data,
      error,
      errorMsg,
      ticketId,
      lastScannedOn,
      stadiumName,
      ticketType,
      ticketQr,
      tooAccNum,
    ) {
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
                Navigator.of(context).pop();
              },
            );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     if (error != true) {
      //       FirebaseFirestore.instance.collection('TicketTransfer').add({
      //         "userId": FirebaseAuth.instance.currentUser!.uid,
      //         "ticketId": ticketId,
      //         "tooAccNum": tooAccNum,
      //         "lastScannedOn": lastScannedOn,
      //         "stadiumName": stadiumName,
      //         "ticketType": ticketType,
      //         "ticketQr": ticketQr
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

    void displayBottomSheet(
      BuildContext context,
      ticketId,
      ticketType,
      lastScannedOn,
      stadiumName,
      ticketQr,
    ) {
      showBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (ctx) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 15,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: accountNumController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Account Number',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 15,
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () async {
                                var res = await transferTicket(
                                  accountNumController.text,
                                  ticketId.toString(),
                                );
                                _showDialog(
                                  res.data,
                                  res.error,
                                  res.errorMsg,
                                  ticketId.toString(),
                                  lastScannedOn,
                                  stadiumName,
                                  ticketType,
                                  ticketQr,
                                  accountNumController.text,
                                );
                                // accountNumController.clear();
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: getTickets,
      child: Scaffold(
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
                    'Tickets',
                    // textAlign: TextAlign.left,
                    style: Styles.headLineStyle.copyWith(
                      fontSize: AppLayout.getWidth(40),
                    ),
                  ),
                ),
                Gap(AppLayout.getHeight(10)),
                FutureBuilder<GetTickets>(
                  future: getTickets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.data;

                      return ListView.builder(
                          physics: const ScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            var item = snapshot.data!.data[index].tickets;
                            if (item.isNotEmpty) {
                              print('Not Empty');
                              return ListView.builder(
                                physics: const ScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: item.length,
                                itemBuilder: (BuildContext context, i) {
                                  var price = snapshot
                                      .data!.data[index].tickets[i].price;
                                  var lastScannedOn = snapshot.data!.data[index]
                                      .tickets[i].lastScannedOn;
                                  var stadiumName = snapshot.data!.data[index]
                                      .tickets[i].stadium.city;
                                  var ticketQr = snapshot
                                      .data!.data[index].tickets[i].ticketQr;
                                  var ticketId = snapshot
                                      .data!.data[index].tickets[i].ticketId;
                                  var ticketType = snapshot
                                      .data!.data[index].tickets[i].ticketType;
                                  var startTime = snapshot.data!.data[index]
                                      .tickets[i].event.eventStartTime;
                                  var description = snapshot.data!.data[index]
                                      .tickets[i].event.eventDescription;
                                  var dis = GetDescriptionEvent.fromJson(
                                      jsonDecode(description));
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                        color: lastScannedOn == '-'
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(21),
                                          bottomRight: Radius.circular(21),
                                          topLeft: Radius.circular(21),
                                          topRight: Radius.circular(21),
                                        ),
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
                                        ]),
                                    child: Column(
                                      children: [
                                        CommonLayout(
                                          mainName: 'Price',
                                          secondaryName:
                                              '${price.toString()} Birr',
                                          number: 'Ticket Type',
                                          secondaryNum:
                                              ticketType.toUpperCase(),
                                          isTop: true,
                                        ),
                                        CommonLayout(
                                          mainName: 'Last Scanned on',
                                          secondaryName: lastScannedOn,
                                          number: 'City',
                                          secondaryNum: stadiumName,
                                        ),
                                        CommonLayout(
                                          mainName: 'Type',
                                          secondaryName: dis.type.toUpperCase(),
                                          number: 'Event Type',
                                          secondaryNum:
                                              '${dis.awayTeam?.name} Vs ${dis.homeTeam?.name}',
                                        ),
                                        lastScannedOn == '-'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // print(dis.type);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              GenerateScreen(
                                                            ticketQr: ticketQr,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                        "Generate Qr.Code"),
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                        'Transfer Ticket'),
                                                    onPressed: () async {
                                                      print(ticketId);
                                                      displayBottomSheet(
                                                        context,
                                                        ticketId,
                                                        ticketType,
                                                        lastScannedOn,
                                                        stadiumName,
                                                        ticketQr,
                                                      );
                                                    },
                                                  )
                                                ],
                                              )
                                            : Container(),
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
                          });
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    }
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Colors.red,
                        // leftDotColor: const Color(0xFF1A1A3F),
                        // rightDotColor: const Color(0xFFEA3799),
                        size: 50,
                      ),
                    );
                  },
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
