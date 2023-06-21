import 'package:bloc/bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/modules/bloc/states.dart';
import '../../constants/components.dart';
import '../../models/current_user.dart';
import '../../models/login_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';
import '../layout_screens/one/screen_one.dart';
import '../layout_screens/two/profile/profile_screen.dart';


class CarCubit extends Cubit<CarStates> {
  CarCubit() : super(TopShopInitialState());

  static CarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  IconData icon = Icons.visibility_off;
  bool isVisible = false;

  void visible() {
    isVisible = !isVisible;
    icon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState());
  }
  List<BottomNavyBarItem> tabs = [
    BottomNavyBarItem(
      icon: const Icon(Icons.car_rental_outlined),
      title: Text(
        "الخدمات",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.account_circle_outlined),
      title: Text(
        "الإعدادات",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
  ];

  List<Widget> screens = [
    const ScreenOne(),
    ProfileScreen(),
  ];

  void changeBot(index) {
    emit(ChangeBotNavState());
    currentIndex = index;
    if (currentIndex == 1) {
      getUserData();
    }
  }

  void login({
    required String email,
    required String password,
    //dynamic token,
    //required BuildContext? context,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'users/signin',
      data: {
        'email': email,
        'password': password,
        token: CacheHelper.getData(key: "token") ?? '',
      },
    ).then((value) {
      //print(value.data['message']);
      LoginModel loginModel = LoginModel.fromJson(value.data);
      getUserData();
      LoginErrorState(loginModel);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      debugPrint('login error $error');
    });
  }

  CurrentUserModel? currentUserModel;

  void getUserData() {
    emit(UserDataLoadingState());
    DioHelper.getData(
      authentication: CacheHelper.getData(key: "token"),
      url: 'users/current-user',
    ).then((value) {
      currentUserModel = CurrentUserModel.fromJson(value.data);
      emit(UserDataSuccessState(currentUserModel!));
    }).catchError((error) {
      emit(UserDataErrorState());
      debugPrint('get current user error $error'.toString());
    });
  }

  double? lat;
  double? long;
  String address = "";
/*
  Future<Position> _determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      buildSnackBar('افتح اللوكيشن', context, 3);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        buildSnackBar('Location permissions are denied', context, 3);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      buildSnackBar(
          'Location permissions are permanently denied, we cannot request permissions.',
          context,
          3);

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    address = placemarks[0].street! + " " + placemarks[0].country!;
    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }
  getLatLong(context) {
    emit(GetLocationLoadingState());
    Future<Position> data = _determinePosition(context);
    data.then((value) {
      emit(GetLocationSuccessState());
      print("value $value");
      lat = value.latitude;
      long = value.longitude;

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      emit(GetLocationErrorState(error));
      print("Error $error");
    });
  }
*/

  void signOut(context) {
    emit(SignOutLoadingState());
    DioHelper.getData(
      authentication: CacheHelper.getData(key: "token"),
      url: 'users/signout',
    ).then((value) {
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState(error));
      print(error.toString());
    });
  }
}