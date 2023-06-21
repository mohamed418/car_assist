import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test1/constants/transitions.dart';
import 'package:test1/layout/car_layout.dart';
import '../../constants/components.dart';
import 'confirm_screen.dart';

class ResultScreen extends StatelessWidget {
  final String role;

  List names = [
    'محمد علي',
    'احمد حسن',
    'عبد العزيز الخولي',
    'محسن فؤاد',
    'حماده ابو علي',
    'كريم محمد',
    'احمد التوني',
    'عبد التواب صابر',
  ];

  List kilo = [
    '10',
    '17',
    '12',
    '5',
    '13',
    '15',
    '18',
    '11',
  ];

  List price = [
    '100',
    '50',
    '70',
    '30',
    '20',
    '130',
    '40',
    '200',
  ];

  ResultScreen({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final random = Random();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.36,
                      height: size.width * 0.36,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 20.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: gradient,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.2),
                        child: Container(
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/person.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * .02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          names[random.nextInt(names.length)],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: size.height * .01),
                        Text(
                          '01112870010',
                          style:TextStyle(
                              fontSize: 20, color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'ما هي المسافه المقدره بينكما',
                  style:TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: size.height * .01),
                RichText(
                  text: TextSpan(
                    text: kilo[random.nextInt(kilo.length)],
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    children: [
                      TextSpan(
                        text: 'كيلو متر',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'السعر : ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(width: size.width * .01),
                    RichText(
                      text: TextSpan(
                        text: '\$',
                        style:TextStyle(
                            fontSize: 17, color: Colors.green,fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: price[random.nextInt(price.length)],
                            style:TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.height * .02))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              CustomPageRoute1(
                                  child: ConfirmScreen(
                                role: role,
                              )));
                        },
                        child: shadeMask(
                          'تأكيد الطلب',
                         TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * .2),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.height * .02))),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  actions: [
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          TextButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child:
                                            shadeMask(
                                              'اختيار عميل اخر',
                                             TextStyle(
                                                  fontSize:
                                                  20),
                                            ),
                                          ),
                                          const SizedBox(
                                              width:
                                              120),
                                          TextButton(
                                            onPressed:
                                                () {
                                                  Navigator.pushReplacement(context, CustomPageRoute1(child: CarLayout()));
                                            },
                                            child:
                                            shadeMask(
                                              'الرجوع للصفحه الرئيسيه',
                                              TextStyle(
                                                  fontSize:
                                                  20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                          );
                        },
                        child: shadeMask(
                          'إلغاء الطلب',
                         TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
