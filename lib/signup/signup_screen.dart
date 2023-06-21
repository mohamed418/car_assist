// ignore_for_file: avoid_print, deprecated_member_use

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../constants/components.dart';
import '../modules/login/login_screen.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_states.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController1 = TextEditingController();

  final _emailController1 = TextEditingController();

  final _passwordController1 = TextEditingController();

  final _mobileController1 = TextEditingController();

  var formSignUpKey = GlobalKey<FormState>();

  _SignUpScreenState();
  //final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => SignUpCubit(),
          child: BlocConsumer<SignUpCubit, SignUpStates>(
            listener: (context, state) {
              if (state is SignUpSuccessState) {
                if (state.loginModel.status == true) {
                  navigateAndFinish(
                    LoginScreen(),
                    context,
                  );
                }
                else {
                  print(state.loginModel.msg);
                  String? m = state.loginModel.msg;
                  MotionToast.error(
                    description: Text(
                      m!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle(fontSize: 15),
                    ),
                    animationType: AnimationType.fromLeft,
                    //layoutOrientation: ORIENTATION.rtl,
                    position: MotionToastPosition.bottom,
                    width: 300,
                    height: 100,
                  ).show(context);
                }
              }
              else if (state is SignUpErrorState) {
                MotionToast.error(
                  description: Text(
                    'اتاكد من البيانات المدخله وحاول مره اخرى',
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
              var cubit = SignUpCubit.get(context);
              return Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                navigateTo(LoginScreen(), context);
                              },
                              icon: const Icon(Icons.arrow_back, size: 30,),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Lottie.asset('assets/lotties/car1.json'),
                        ),
                        Form(
                          key: formSignUpKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.3),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _emailController1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ادخل البريد الالكتروني';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        //hintText: 'ادخل بريدك الالكتروني',
                                        label: Text(
                                          'الايميل',
                                        style: TextStyle(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _passwordController1,
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
                                            cubit.visible1();
                                          },
                                          icon: Icon(cubit.icon1),
                                        ),

                                        //hintText: 'enter a valid password',
                                        label: Text('كلمة المرور',
                                          style:TextStyle(),
                                        ),
                                      ),
                                      obscureText: cubit.isVisible1,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: _nameController1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ادخل اسمك';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        //hintText: 'enter your name',
                                        label: Text(
                                          'الاسم',
                                        style:TextStyle(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: _mobileController1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ادخل رقم الهاتف';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        //hintText: 'enter your mobile number',
                                        label: Text(
                                          'رقم الهاتف',
                                        style: TextStyle(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    BuildCondition(
                                      condition: state is! SignUpLoadingState,
                                      builder: (context) =>
                                          ElevatedButton(
                                            onPressed: () {
                                                if (formSignUpKey.currentState!
                                                    .validate()) {
                                                  FocusScope.of(context).unfocus();
                                                  SignUpCubit.get(context)
                                                      .userSignUp(
                                                    name: _nameController1.text,
                                                    email: _emailController1.text,
                                                    password: _passwordController1.text,
                                                    mobile: _mobileController1.text,
                                                  );
                                                } else {
                                                  FocusScope.of(context).unfocus();
                                                }
                                            },
                                            child: Text('تسجيل'.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                          ),
                                      fallback: (context) =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(),));

                                            // navigateAndFinish(
                                            //     LoginScreen(), context);
                                          },
                                          child: Text(
                                            'لديك حساب بالفعل؟',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
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
              );
            },
          ),
        ),
      ),
    );
  }
}


