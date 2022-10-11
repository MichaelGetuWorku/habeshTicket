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
import 'package:login/utils/fab.dart';
import 'package:login/widgets/chips.dart';
import 'package:login/widgets/commonLayout.dart';
import 'package:login/widgets/ticket_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var accountNumController = TextEditingController();

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      floatingActionButton: const FAB(),
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
                  'Purchase History',
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
                                var price =
                                    snapshot.data!.data[index].tickets[i].price;
                                var lastScannedOn = snapshot
                                    .data!.data[index].tickets[i].lastScannedOn;
                                var stadiumName = snapshot
                                    .data!.data[index].tickets[i].stadium.city;
                                var ticketType = snapshot
                                    .data!.data[index].tickets[i].ticketType;
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
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      CommonLayout(
                                        mainName: 'Price',
                                        secondaryName:
                                            '${price.toString()} Birr',
                                        number: 'Ticket Type',
                                        secondaryNum: ticketType.toUpperCase(),
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
                                            '${dis.awayTeam?.name ?? ''} Vs ${dis.homeTeam?.name ?? dis.eventDescriptionText}',
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
    );
  }
}