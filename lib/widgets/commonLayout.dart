// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';

class CommonLayout extends StatelessWidget {
  final String mainName;
  final String secondaryName;
  final String number;
  final String secondaryNum;
  final bool? isImage;
  final bool? isTop;
  const CommonLayout({
    Key? key,
    required this.mainName,
    required this.secondaryName,
    required this.number,
    required this.secondaryNum,
    this.isImage,
    this.isTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          isTop == null ? const SizedBox() : const dotDotDot(),
          isTop == null
              ? const SizedBox()
              : const SizedBox(
                  height: 15,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainName,
                    style: Styles.headLineStyle3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Gap(AppLayout.getHeight(5)),
                  Text(
                    secondaryName,
                    style: Styles.headLineStyle3.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    number,
                    style: Styles.headLineStyle3.copyWith(color: Colors.black),
                  ),
                  Gap(AppLayout.getHeight(5)),
                  Text(
                    secondaryNum,
                    style: Styles.headLineStyle3.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          const dotDotDot(),
        ],
      ),
    );
  }
}

class dotDotDot extends StatelessWidget {
  const dotDotDot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(24),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              (constraints.constrainWidth() / 6).floor(),
              (index) => SizedBox(
                width: AppLayout.getWidth(3),
                height: AppLayout.getHeight(1),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
