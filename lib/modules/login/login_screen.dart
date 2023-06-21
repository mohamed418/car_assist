// ignore_for_file: avoid_print
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../constants/components.dart';
import '../../layout/car_layout.dart';
import '../../network/local/cache_helper.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../signup/signup_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status == true) {
            
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.token!,
            ).then((value) {
            
              token = state.loginModel.token!;
              print('check : ${CacheHelper.getData(key: "token")}');
              navigateAndFinish(
                CarLayout(),
                context,
              );
              CarCubit.get(context).getUserData();
            }).catchError((error) {
              print('error from login screen cacheHelper${error.toString()}');
            });
            print('token from loginError : ${state.loginModel.token!}');
            print(
                'token from login2Error : ${CacheHelper.getData(key: 'token')}');
          } else {
            print('elseseseseseseseseseeeee   ${state.loginModel.msg}');
            String? m = state.loginModel.msg;
            MotionToast.error(
              description: Text(
                m!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15),
              ),
              animationType: AnimationType.fromLeft,
              //layoutOrientation: ORIENTATION.rtl,
              position: MotionToastPosition.bottom,
              width: 300,
              height: 100,
            ).show(context);
          }
        }
        else if (state is LoginErrorState) {
          MotionToast.error(
            description: const Text(
              'please check your inputs',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            animationType: AnimationType.fromLeft,
            //layoutOrientation: ORIENTATION.rtl,
            position: MotionToastPosition.bottom,
            width: 300,
            height: 100,
          ).show(context);
        }
      },
      builder: (context, state) {
        final cubit = CarCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      // height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: Lottie.asset('assets/lotties/car1.json'),
                    ),
                    Form(
                      key: formLoginKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.3),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: emailController,
                                  validator:
                                      (value) {
                                    if (value!.isEmpty) {
                                      return 'ادخل البريد الالكتروني';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    //hintText: 'enter your email',
                                    label: Text(
                                      'الايميل',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'ادخل كلمة المرور';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.visible();
                                      },
                                      icon: Icon(cubit.icon),
                                    ),
                                    label: Text(
                                      'كلمة المرور',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  obscureText: cubit.isVisible,
                                  onFieldSubmitted: (v) {
                                  
                                    if (formLoginKey.currentState!.validate()) {
                                      
                                      FocusScope.of(context).unfocus();
                                      CarCubit.get(context).login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        
                                      );
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen(),));
                                        
                                      },
                                      child: Text(
                                        'ليس لديك حساب؟',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(height: 30),
                                BuildCondition(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => ElevatedButton(
                                    onPressed: () {
                                      if (formLoginKey.currentState!
                                          .validate()) {
                                        
                                        FocusScope.of(context).unfocus();
                                        CarCubit.get(context).login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          
                                        );
                                      } else {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: Text('تسجيل الدخول',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
