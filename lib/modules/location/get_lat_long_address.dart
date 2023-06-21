import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../constants/transitions.dart';
import '../../map/home_screen.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

class GetLatLongScreen extends StatefulWidget {
  static const String routeName = 'getLatLng';

  final dynamic prevScreen;
  final dynamic orderId;
  final dynamic productId;
  final dynamic productPrice;
  final dynamic productImg;
  final dynamic productName;
  final dynamic productDesc;
  final dynamic sellerName;
  final dynamic userId;
  final String role;

  const GetLatLongScreen({
    super.key,
    this.prevScreen,
    this.orderId,
    this.productId,
    this.productPrice,
    this.productImg,
    this.productName,
    this.productDesc,
    this.sellerName,
    this.userId,
    required this.role,
  });

  @override
  State<GetLatLongScreen> createState() => _GetLatLongScreenState(
        prevScreen,
        orderId,
        productId,
        productPrice,
        productImg,
        productName,
        productDesc,
        sellerName,
        userId,
        role,
      );
}

class _GetLatLongScreenState extends State<GetLatLongScreen> {
  final dynamic prevScreen;
  final dynamic orderId;
  final dynamic productId;
  final dynamic productPrice;
  final dynamic productImg;
  final dynamic productName;
  final dynamic productDesc;
  final dynamic sellerName;
  final dynamic userId;
  final String role;

  _GetLatLongScreenState(
    this.prevScreen,
    this.orderId,
    this.productId,
    this.productPrice,
    this.productImg,
    this.productName,
    this.productDesc,
    this.sellerName,
    this.userId,
    this.role,
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<CarCubit, CarStates>(
        listener: (context, state) {
          // if (state is GetLocationSuccessState) {
          Navigator.push(
            context,
            CustomPageRoute(
              child: homeScreen(
                role: role,
              ),
            ),
            // MaterialPageRoute(builder: (context) => homeScreen()),
          );
          // }
        },
        builder: (context, state) {
          final cubit = CarCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30,
                          ),
                        ),
                      ),
                      Lottie.asset('assets/lotties/location.json'),
                      Text(
                        'قم بتحديد مكانك الحالي لتجربه افضل',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 70),
                      BuildCondition(
                        condition: state is! GetLocationLoadingState,
                        //condition: true,
                        builder: (context) => ElevatedButton(
                            onPressed: () {
                              // MaterialPageRoute(
                              // builder: (context) => homeScreen(),
                              Navigator.pushReplacement(
                                  context,
                                  CustomPageRoute(
                                    child: homeScreen(
                                      role: role,
                                    ),
                                  ));
                              // );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'تحديد',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            )),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
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
