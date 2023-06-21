import '../../models/current_user.dart';
import '../../models/login_model.dart';

abstract class CarStates{}

class TopShopInitialState extends CarStates{}

class ChangeBotNavState extends CarStates{}

class ChangeBottomNavState extends CarStates{}

class TopShopLoadingState extends CarStates{}

class TopShopSuccessState extends CarStates{}

class TopShopErrorState extends CarStates{}


class UserDataLoadingState extends CarStates {}

class UserDataSuccessState extends CarStates {
  final CurrentUserModel currentUserModel;
  UserDataSuccessState(this.currentUserModel);
}

class UserDataErrorState extends CarStates {}

class LoginSuccessState extends CarStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginLoadingState extends CarStates{}

class LoginErrorState extends CarStates{
  final dynamic loginModel;
  final String error;

  LoginErrorState([this.loginModel, this.error = '']);
}
class GetLocationLoadingState extends CarStates{}

class GetLocationSuccessState extends CarStates{}

class GetLocationErrorState extends CarStates{
  final dynamic error;
  GetLocationErrorState(this.error);
}

class SignOutLoadingState extends CarStates{}

class SignOutSuccessState extends CarStates{}

class SignOutErrorState extends CarStates{
  final dynamic error;
  SignOutErrorState(this.error);
}