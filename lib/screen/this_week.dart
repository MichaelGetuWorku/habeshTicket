// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/api/get_event.dart';
import 'package:login/model/get_event.dart';
import 'package:login/screen/single_ticket.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/error_message.dart';
import 'package:login/utils/loading_widet.dart';
import 'package:login/widgets/ticket_view.dart';

class ThisWeekScreen extends StatefulWidget {
  const ThisWeekScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ThisWeekScreen> createState() => _ThisWeekScreenState();
}

class _ThisWeekScreenState extends State<ThisWeekScreen> {
  late Future<GetEvent> futureEvents;
  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: _events(),
    );
  }

  Future<void> _pullRefresh() async {
    Future<GetEvent> futureLedger = fetchEvent();
    setState(() {
      futureEvents = Future.value(futureLedger);
    });
  }
}

class _events extends StatelessWidget {
  const _events({
    Key? key,
  }) : super(key: key);

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
          return const ErrorMessage(
            mss: 'Available Tickets',
          );
        }
        return const LoadingWidget();
      },
    );
  }
}
