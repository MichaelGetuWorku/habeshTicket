import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/api/get_event.dart';
import 'package:login/model/get_event.dart';
import 'package:login/screen/this_week.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<GetEvent> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(AppLayout.getHeight(30)),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Text(
                  'HabeshTickets',
                  // textAlign: TextAlign.left,
                  style: Styles.headLineStyle.copyWith(
                    fontSize: AppLayout.getWidth(40),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(10)),
              const ThisWeekScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    Future<GetEvent> futureLedger = fetchEvent();
    setState(() {
      futureEvents = Future.value(futureLedger);
    });
  }
}
