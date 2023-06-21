import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import '../../../network/remote/dio_helper.dart';
import 'register_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  void userSignUp({
    String? name,
    String? email,
    String? password,
    String? mobile,
    String? role,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(url: 'users/signup', data: {
      "name": name,
      "email": email,
      'password': password,
      "mobile": mobile,
      "role": role,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(SignUpSuccessState(loginModel!));
      debugPrint(loginModel!.msg);
    }).catchError((error) {
      debugPrint('error: $error');
      emit(SignUpErrorState(error.toString()));
    });
  }



  IconData icon1 = Icons.visibility_off;
  bool isVisible1 = false;

  void visible1() {
    isVisible1 = !isVisible1;
    icon1 = isVisible1 ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState1());
  }

}
