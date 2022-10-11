// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/api/buy_ticket.dart';
import 'package:login/model/get_event.dart';
import 'package:login/screen/bottom_bar.dart';
import 'package:login/screen/ticket_screen.dart';
import 'package:login/widgets/action_button.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

var qualityController = TextEditingController();

class ChoiceChips extends StatefulWidget {
  // final int availableTickets;
  // final double price;
  // final String type;
  final List<EventTickets> eventTickets;
  final int eventId;
  final int stadiumId;

  ChoiceChips({
    Key? key,
    required this.eventTickets,
    required this.eventId,
    required this.stadiumId,
    // required this.availableTickets,
    // required this.price,
    // required this.type,
  });
  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  var idSelected = 0;
  var ticketType;
  bool loading = false;

  void _showDialog(BuildContext context, error, errorMsg, quantity) {
    error == true
        ? QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: '$errorMsg or Ticket type or Quantity is missing',
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            },
          )
        : QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Payment",
            text: "Congrats your payment was successful!",
            onConfirmBtnTap: () {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const BottomBar(),
                ),
              );
            },
          );

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // if (error != true) {
    //     //   // create a firebase doc and send the UID,event_id,ticketType
    //     //   FirebaseFirestore.instance.collection('Tickets').add({
    //     //     "userId": FirebaseAuth.instance.currentUser!.uid,
    //     //     "eventId": widget.eventId,
    //     //     "ticketType": ticketType,
    //     //     "quantity": quantity,
    //     //     "date": dateNow,
    //     //     "time": timeNow,
    //     //     "eventType": "Football",
    //     //     "stadiumId": widget.stadiumId,
    //     //   });
    //     // }
    //     return AlertDialog(
    //       title: error == true ? const Text("Error") : const Text('Payment'),
    //       content: error == true
    //           ? Text(errorMsg)
    //           : const Text('Congrats your payment was successful!'),
    //       actions: [
    //         TextButton(
    //           child: const Text('Ok'),
    //           onPressed: () {
    //             error == true
    //                 ? Navigator.of(context).pop()
    //                 : Navigator.of(context).push(
    //                     MaterialPageRoute(
    //                       builder: (context) => const TicketScreen(),
    //                     ),
    //                   );
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void displayBottomSheet(
    BuildContext context,
    ticketType,
    quantity,
    eventId,
  ) {
    showModalBottomSheet(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Purchase Summery',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ticketType != null
                      ? Text(
                          "Ticket Type: $ticketType",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )
                      : const Text(
                          "Ticket Type: Ticket Type is Required!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  const SizedBox(height: 15),
                  quantity != ''
                      ? Text(
                          "Quantity: $quantity",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )
                      : const Text(
                          "Quantity: Quantity is Required!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 300,
                    child: ActionButton(
                      name: 'Confirm Payment',
                      action: () async {
                        var res = await buyTicket(
                          eventId,
                          ticketType,
                          quantity,
                        );
                      _showDialog(
                                context,
                                res.error,
                                res.errorMsg,
                                quantity,
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final eventChoices = <EventTicket>[
      EventTicket(
        widget.eventTickets,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              runSpacing: 20,
              spacing: 8,
              children: eventChoices[0]
                  .eventTickets
                  .map(
                    (e) => ChoiceChip(
                      // selectedColor: Colors.amber,
                      label: Container(
                        width: 250,
                        height: 50,
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              e.type.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$ ${e.price.toString()}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      selected: idSelected == e.price.toInt(),
                      onSelected: (_) => setState(
                        () {
                          idSelected = e.price.toInt();
                          print(idSelected);
                          ticketType = e.type;
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: qualityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantity',
                hintText: 'Enter Number',
              ),
            ),
            const SizedBox(height: 15),
            ActionButton(
              name: 'Proceed to Pay',
              action: () {
                print(
                  ticketType,
                );
                print(
                  qualityController.text,
                );
                print(widget.eventId);
                // buyTicket(
                //   widget.eventId,
                //   ticketType,
                //   qualityController.text,
                // );
                displayBottomSheet(
                  context,
                  ticketType,
                  qualityController.text,
                  widget.eventId,
                );
                qualityController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EventTicket {
  final List<EventTickets> eventTickets;

  EventTicket(this.eventTickets);
}
