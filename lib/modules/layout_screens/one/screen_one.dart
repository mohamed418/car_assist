import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/components.dart';
import '../../../constants/transitions.dart';
import '../../location/get_lat_long_address.dart';
import 'fix_screen.dart';
import 'other_screen.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildContainer(
                size,
                'a1',
                'ونش',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const GetLatLongScreen(role: 'wn4',),
                  ),
                ),
              ),
              buildContainer(
                size,
                'a2',
                'تبديل كاوتش',
                    () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Lottie.asset('assets/lotties/a2.json'),
                    actions: [
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute1(
                                    child: const GetLatLongScreen(role: 'cawtch',),
                                  ),
                                );
                              },
                              child: shadeMask(
                                ' لدي استبن',
                                TextStyle(fontSize: 20),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute1(
                                    child: const GetLatLongScreen(role: 'cawtch',),
                                  ),
                                );
                              },
                              child: shadeMask(
                                'ليس لدي استبن',
                                TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              buildContainer(
                size,
                'a5',
                'تصليح عطل',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const FixScreen(),
                  ),
                ),
              ),
              buildContainer(
                size,
                'a4',
                'أخرى',
                    () => Navigator.push(
                  context,
                  CustomPageRoute1(
                    child: const OtherScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildContainer(Size size, lottie, text, function) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            function();
          },
          child: Container(
            height: size.height * .3,
            width: size.width * .8,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(size.width * .1)),
            ),
            child: Column(
              children: [
                Lottie.asset('assets/lotties/$lottie.json',
                    height: size.height * .15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    '$text',
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * .02),
      ],
    );
  }
}
