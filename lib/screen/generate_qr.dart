import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:login/screen/bottom_bar.dart';
import 'package:login/utils/app_layout.dart';
import 'package:login/utils/app_styles.dart';
import 'package:login/utils/fab.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:path_provider/path_provider.dart';

class GenerateScreen extends StatefulWidget {
  final String ticketQr;
  const GenerateScreen({
    Key? key,
    required this.ticketQr,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = GlobalKey();
  late String _inputErrorText = '';

  late final String _dataString = widget.ticketQr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: Styles.bgColor,
      child: Column(
        children: [
          Gap(AppLayout.getHeight(40)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Your QrImage is ready.',
              style: Styles.headLineStyle.copyWith(
                fontSize: AppLayout.getWidth(40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              // top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ),
          ),
          Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                padding: const EdgeInsets.all(25),
                data: _dataString,
                // size: 0.5 * bodyHeight,
                size: 300,

                errorStateBuilder: (context, error) {
                  print("[QR] ERROR - $error");
                  setState(() {
                    _inputErrorText =
                        "Error! Maybe your input value is too long?";
                  });
                  return const Text('');
                },
              ),
            ),
          ),
          const Center(
            child: Text('Please show this in the entry of the stadium.'),
          ),
          const SizedBox(height: 15),
          const Text(
            'Congratulations!!',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your Ticket has been booked \n we hope you had a good time!',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black38,
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              Get.offAll(
                () => const BottomBar(),
              );
            },
            child: const Text('Navigate to home!'),
          ),
        ],
      ),
    );
  }
}
