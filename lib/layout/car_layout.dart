import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/bloc/cubit.dart';
import '../modules/bloc/states.dart';

class CarLayout extends StatelessWidget {
  // const CarLayout({Key? key}) : super(key: key);
  static const String routeName = 'car-layout';

  @override
  Widget build(BuildContext context) {
    var cubit = CarCubit.get(context);
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SafeArea(child: cubit.screens[cubit.currentIndex]),
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: cubit.currentIndex,
              showElevation: true,
              containerHeight: 60,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              iconSize: 30,
              onItemSelected: (index) => cubit.changeBot(index),
              items: cubit.tabs,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        );
      },
    );
  }
}
// ResponsiveNavigationBar(
// selectedIndex: cubit.currentIndex,
// onTabChange: (index) {
// cubit.changeBot(index);
// },
// navigationBarButtons: cubit.tabs,
// backgroundGradient: gradient,
// inactiveIconColor: Colors.blue,
// textStyle: const TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// ),
// )
