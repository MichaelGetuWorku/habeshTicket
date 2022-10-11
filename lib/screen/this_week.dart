// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login/api/get_event.dart';
import 'package:login/model/get_details.dart';
import 'package:login/model/get_event.dart';
import 'package:login/screen/single_ticket.dart';
import 'package:login/utils/const.dart';
import 'package:login/widgets/ticket_view.dart';
import 'package:http/http.dart' as http;

class ThisWeekScreen extends StatefulWidget {
  const ThisWeekScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ThisWeekScreen> createState() => _ThisWeekScreenState();
}

class _ThisWeekScreenState extends State<ThisWeekScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetEvent>(
      future: fetchEvent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.data.events;
          return ListView.builder(
            physics: const ScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var timeStamp =
                  int.parse(snapshot.data!.data.events[index].eventStartTime);
              var date = DateTime.fromMillisecondsSinceEpoch(
                timeStamp * 1000,
              );
              String formattedTime = DateFormat('hh:mm').format(date);
              String formattedDate = DateFormat('EEEE d MMM').format(date);
              var id = snapshot.data!.data.events[index].eventId;
              var eventDescriptionAway =
                  snapshot.data!.data.events[index].eventDescription.awayTeam;
              var eventDescriptionHome =
                  snapshot.data!.data.events[index].eventDescription.homeTeam;
              var awayName = eventDescriptionAway?.name ?? '';
              var otherName = snapshot.data!.data.events[index].eventDescription
                  .eventDescriptionText;
              var homeName = eventDescriptionHome?.name ?? otherName;
              var awayCountryId = eventDescriptionAway?.countryId ?? '';
              var homeCountryId = eventDescriptionHome?.countryId ?? '';

              var awayTeamId = eventDescriptionAway?.teamId ?? '';
              var homeTeamId = eventDescriptionHome?.teamId ?? '';
              var stadiumName = snapshot.data!.data.events[index].stadium.city;
              var stadiumId =
                  snapshot.data!.data.events[index].stadium.stadiumId;
              var eventTickets = snapshot.data!.data.events[index].eventTickets;
              var eventType =
                  snapshot.data!.data.events[index].eventDescription.type;
              var subType =
                  snapshot.data!.data.events[index].eventDescription.subType;

              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleTicket(
                            id: id,
                            eventDescription: '',
                            stadiumName: stadiumName,
                            eventTickets: eventTickets,
                            eventTime: formattedTime,
                            date: formattedDate,
                            stadiumId: stadiumId,
                            awayName: awayName,
                            homeName: homeName,
                            eventType: eventType,
                            subType: subType,
                            awayCountryId: awayCountryId,
                            homeCountryId: homeCountryId,
                            awayTeamId: awayTeamId,
                            homeTeamId: homeTeamId,
                            otherName: otherName,
                          ),
                        ),
                      );
                    },
                    child: TicketView(
                      time: formattedTime,
                      stadium: stadiumName,
                      awayName: awayName,
                      homeName: homeName,
                      otherName: otherName,
                      type: eventType,
                    ),
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error Couldn\'t get ticks check your internet connection or contact our help and support',
            ),
          );
        }
        return Center(
          child: LoadingAnimationWidget.inkDrop(
            color: Colors.red,
            size: 50,
          ),
        );
      },
    );
  }
}
