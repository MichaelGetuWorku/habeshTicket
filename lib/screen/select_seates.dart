import 'package:flutter/material.dart';
import 'package:login/model/get_event.dart';
import 'package:login/utils/fab.dart';
import 'package:login/widgets/choice_chips.dart';

class SelectSeats extends StatelessWidget {
  final List<EventTickets> eventTickets;
  final int eventId;
  final int stadiumId;

  const SelectSeats({
    Key? key,
    required this.eventTickets,
    required this.eventId,
    required this.stadiumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FAB(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Seats',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 17),
              Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade300,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/seats.jpg"),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ChoiceChips(
                eventTickets: eventTickets,
                eventId: eventId,
                stadiumId: stadiumId,
              )
            ],
          ),
        ),
      ),
    );
  }
}
