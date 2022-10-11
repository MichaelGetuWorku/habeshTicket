import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/api/get_event.dart';
import 'package:login/screen/this_week.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: RefreshIndicator(
        onRefresh: fetchEvent,
        child: SingleChildScrollView(
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
      ),
    );
    // DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     body: NestedScrollView(
    //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //         return [
    //           const SliverAppBar(
    //             title: Text('HabeshTicket'),
    //             pinned: true,
    //             floating: true,
    //             bottom: TabBar(
    //               indicatorColor: Colors.amberAccent,
    //               indicatorWeight: 5,
    //               // indicator: BoxDecoration(color: Colors.greenAccent), //Ch
    //               tabs: [
    //                 Tab(
    //                   child: Text(
    //                     'This Week',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ),
    //                 Tab(
    //                   child: Text(
    //                     'This Month',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ];
    //       },
    //       body: const TabBarView(
    //         children: [
    //           ThisWeekScreen(),
    //           ThisWeekScreen(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
