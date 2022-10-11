import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/widgets/thick_contianer.dart';

class TicketView extends StatelessWidget {
  final String time;
  final String? awayName;
  final String? homeName;
  final String? awayCountryId;
  final String? homeCountryId;
  final String stadium;
  final String? otherName;
  final String? type;
  const TicketView({
    Key? key,
    required this.time,
    this.awayName,
    this.homeName,
    this.awayCountryId,
    this.homeCountryId,
    this.otherName,
    this.type,
    required this.stadium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: size.width * 0.87,
        height: AppLayout.getHeight(220),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Styles.blueBlack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppLayout.getHeight(21)),
                  topRight: Radius.circular(AppLayout.getHeight(21)),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  type == 'football'
                      ? Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$awayName',
                                    style: Styles.headLineStyle3.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: AppLayout.getHeight(24),
                                      child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          return Flex(
                                            direction: Axis.horizontal,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                              (constraints.constrainWidth() / 6)
                                                  .floor(),
                                              (index) => SizedBox(
                                                width: AppLayout.getWidth(3),
                                                height: AppLayout.getHeight(1),
                                                child: const DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const Text(
                                      'Vs',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    homeName!,
                                    style: Styles.headLineStyle3.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              otherName!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                  const Gap(15),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'ticket from',
                  //       style: Styles.headLineStyle4.copyWith(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     Text(
                  //       'ticket flying_time ',
                  //       style: Styles.headLineStyle4.copyWith(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ),
                  //     Expanded(
                  //       child: Container(),
                  //     ),
                  //     Text(
                  //       'ticket to name}',
                  //       style: Styles.headLineStyle3.copyWith(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              color: Styles.orangeColor,
              child: Row(
                children: [
                  SizedBox(
                    height: AppLayout.getHeight(20),
                    width: AppLayout.getWidth(20),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                              (constraints.constrainWidth() / 15).floor(),
                              (index) => SizedBox(
                                width: AppLayout.getWidth(5),
                                height: AppLayout.getHeight(1),
                                child: const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppLayout.getHeight(20),
                    width: AppLayout.getWidth(20),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(21),
                          bottomLeft: Radius.circular(21),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Styles.orangeColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(21),
                  bottomRight: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 10,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: Styles.headLineStyle3.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            time,
                            style: Styles.headLineStyle4.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Stadium',
                      //       style: Styles.headLineStyle3.copyWith(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     const Gap(5),
                      //     Text(
                      //       stadium,
                      //       style: Styles.headLineStyle4.copyWith(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text(
                          //   'Ticket',
                          //   style: Styles.headLineStyle3.copyWith(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          // const Gap(5),
                          // Text(
                          //   vip.toString(),
                          //   style: Styles.headLineStyle4.copyWith(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          // Text(
                          //   normal.toString(),
                          //   style: Styles.headLineStyle4.copyWith(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          Text(
                            'Stadium',
                            style: Styles.headLineStyle3.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            stadium,
                            style: Styles.headLineStyle4.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
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
