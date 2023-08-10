// ignore_for_file: must_be_immutable

import 'package:ephoneandsystems/alerts/alerts.dart';
import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/utils/image_path.dart';
import 'package:ephoneandsystems/utils/instances.dart';
import 'package:ephoneandsystems/widgets/text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeviceNotConnected extends StatefulWidget {
  DeviceNotConnected({required this.webViewController, super.key});
  late final WebViewController webViewController;
  @override
  State<DeviceNotConnected> createState() => _DeviceNotConnectedState();
}

class _DeviceNotConnectedState extends State<DeviceNotConnected> {
  @override
  void initState() {
    super.initState();
    Alerts.close();
  }

  double _width = 400;
  double _height = 50.0;
  void _tapDown(TapDownDetails details) {
    setState(() {
      _width = 300.0;
      _height = 36.0;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      _width = 400.0;
      _height = 50.0;
    });
  }

  void _tapCancel() {
    setState(() {
      _width = 400;
      _height = 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageName(Img.lostConnection),
              // height: 150,
            ),
            TextOf(
              text: "Something went wrong",
              size: 20,
              weight: FontWeight.w800,
              color: black,
            ),
            const SizedBox(
              height: 5,
            ),
            TextOf(
              text:
                  "Seems like you lost your internet connection.\nRestore your connection and try again!",
              size: 12,
              weight: FontWeight.w400,
              color: black,
              align: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            // InkWell(
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //     width: MediaQuery.of(context).size.width * 0.7,
            //     decoration: BoxDecoration(
            //       color: primaryColor,
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     child: Center(
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(
            //       Icons.replay_outlined,
            //       color: white,
            //       size: 25,
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     TextOf(
            //       text: 'Try again',
            //       size: 20,
            //       weight: FontWeight.w600,
            //       color: white,
            //     ),
            //   ],
            // ),
            //     ),
            //   ),
            //   onTap: ()=>widget.webViewController.reload(),
            // )

            GestureDetector(
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              onTapCancel: _tapCancel,
              onTap: () {
                widget.webViewController.reload();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColor,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.replay_outlined,
                        color: white,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextOf(
                        text: 'Try again',
                        size: 20,
                        weight: FontWeight.w600,
                        color: white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
