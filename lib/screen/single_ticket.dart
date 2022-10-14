import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/model/get_event.dart';
import 'package:login/screen/select_seates.dart';
import 'package:login/utils/fab.dart';
import 'package:login/widgets/action_button.dart';

class SingleTicket extends StatelessWidget {
  final int id;
  final String eventDescription;
  final String stadiumName;
  final List<EventTickets> eventTickets;
  final String eventTime;
  final String date;
  final int stadiumId;
  final String awayName;
  final String homeName;
  final String eventType;
  final String subType;
  final String homeCountryId;
  final String awayCountryId;
  final dynamic awayTeamId;
  final dynamic homeTeamId;
  final String otherName;
  const SingleTicket({
    Key? key,
    required this.id,
    required this.eventDescription,
    required this.stadiumName,
    required this.eventTickets,
    required this.eventTime,
    required this.date,
    required this.stadiumId,
    required this.awayName,
    required this.homeName,
    required this.eventType,
    required this.subType,
    required this.awayCountryId,
    required this.homeCountryId,
    required this.awayTeamId,
    required this.homeTeamId,
    required this.otherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FAB(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(
          parent: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: eventTickets.length > 2
                  ? MediaQuery.of(context).size.height * 1.23
                  : eventTickets.length > 1
                      ? MediaQuery.of(context).size.height * 1.15
                      : MediaQuery.of(context).size.height * 1.05,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 17),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/stadium.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  eventType == 'football'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  maxRadius: 40,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: subType == 'international'
                                      ? NetworkImage(
                                          'https://habesha-stadium.herokuapp.com///get_country_flag?country_id=$homeCountryId')
                                      : NetworkImage(
                                          'https://habesha-stadium.herokuapp.com//get_team_logo?team_id=$homeTeamId'),
                                ),
                                const Gap(12),
                                Text(
                                  homeName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Vs',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  maxRadius: 40,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: subType == 'international'
                                      ? NetworkImage(
                                          'https://habesha-stadium.herokuapp.com///get_country_flag?country_id=$awayCountryId')
                                      : NetworkImage(
                                          'https://habesha-stadium.herokuapp.com//get_team_logo?team_id=$awayTeamId'),
                                ),
                                const Gap(12),
                                Text(
                                  awayName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text(
                          otherName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 20),
                  const Text(
                    'Match Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DetailsWidget(
                    name: 'Date',
                    describes: date,
                  ),
                  DetailsWidget(
                    name: 'Starting Price',
                    describes: eventTickets.isNotEmpty
                        ? '\$ ${eventTickets[0].price}'
                        : 'Ticket Sold Out!.',
                  ),
                  DetailsWidget(
                    name: 'Time',
                    describes: eventTime,
                  ),
                  DetailsWidget(
                    name: 'Stadium',
                    describes: stadiumName,
                  ),
                  DetailsWidget(
                    name: 'Event Type',
                    describes: eventType.toUpperCase(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ticket',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  eventTickets.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            physics: const ScrollPhysics(
                              parent: NeverScrollableScrollPhysics(),
                            ),
                            itemCount: eventTickets.length,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                // height: 100,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              eventTickets[index]
                                                  .type
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' : ${eventTickets[index].price.toString()} \$',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Available Seats',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' : ${eventTickets[index].availableTickets.toString()}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Text(
                          'Ticket is Sold Out!!',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  const Gap(15),
                  SizedBox(
                    width: 250,
                    child: eventTickets.isNotEmpty
                        ? ActionButton(
                            name: 'Continue',
                            action: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectSeats(
                                    eventTickets: eventTickets,
                                    eventId: id,
                                    stadiumId: stadiumId,
                                  ),
                                ),
                              );
                            },
                          )
                        : ActionButton(
                            name: 'Sold Out!!',
                            action: () {
                              Navigator.pop(context);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final String name;
  final String describes;
  const DetailsWidget({
    Key? key,
    required this.describes,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$name: ',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            Text(
              describes,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
