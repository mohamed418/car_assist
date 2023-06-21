import 'dart:io';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../../constants/components.dart';
import '../../../../constants/transitions.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../bloc/cubit.dart';
import '../../../bloc/states.dart';
import '../../../login/login_screen.dart';
import '../help.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  var formProfileKey = GlobalKey<FormState>();

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImage(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var cubit = CarCubit.get(context);
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CarCubit.get(context).getUserData();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: BuildCondition(
                condition: state is! UserDataLoadingState,
                builder: (context) => CacheHelper.getData(key: 'token') != null
                    ? BuildCondition(
                        condition: cubit.currentUserModel != null,
                        builder: (context) => Form(
                          key: formProfileKey,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * .4,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(50)),
                                    gradient: gradient,
                                    color: Colors.blueGrey.withOpacity(.3),
                                  ),
                                  child: Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              image == null
                                                  ? Container(
                                                      width: size.width * 0.46,
                                                      height: size.width * 0.46,
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 24.0,
                                                        bottom: 20.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient: gradient,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.2),
                                                        child: Container(
                                                          height: 80,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                                  image: AssetImage('assets/images/person.png'),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: size.width * 0.46,
                                                      height: size.width * 0.46,
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 24.0,
                                                        bottom: 20.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient: gradient,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.2),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: ClipOval(
                                                            child: Image.file(
                                                              image!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              Positioned(
                                                bottom: 25,
                                                right: 4,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          30, 10, 100, 1),
                                                  //backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            AlertDialog(
                                                          content: Lottie.asset(
                                                            'assets/lotties/image.json',
                                                          ),
                                                          actions: [
                                                            Center(
                                                              child: Row(
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
                                                                      pickImage(
                                                                        ImageSource
                                                                            .camera,
                                                                      );
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        shadeMask(
                                                                      'Camera',
                                                                      const TextStyle(
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
                                                                      pickImage(
                                                                        ImageSource
                                                                            .gallery,
                                                                      );
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        shadeMask(
                                                                      'Gallery',
                                                                      const TextStyle(
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
                                                    icon: iconSh(Icons.camera,
                                                        size: 30),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Text(
                                              cubit.currentUserModel!.name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 30,
                                                  color: defaultColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          //const SizedBox(height: 5),
                                          Expanded(
                                            child: Text(
                                              cubit.currentUserModel!.email,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 20,
                                                  color: defaultColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ]),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      buildElevatedButton(
                                        context,
                                        () => Navigator.push(context, CustomPageRoute1(child: const HelpScreen())),
                                        'الاقتراحات',
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: size.height*.01),
                                        child: buildElevatedButton(
                                          context,
                                          () {
                                            cubit.signOut(context);
                                            CacheHelper.removeData(
                                                key: "token");
                                            cubit.currentUserModel = null;
                                            navigateAndFinish(
                                              LoginScreen(),
                                              context,
                                            );
                                          },
                                          'تسجيل خروج',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        children: [
                          Lottie.asset('assets/lotties/secure.json'),
                          Text(
                            'قم بتسجيل الدخول لاول مره واستمتع بتجربه هي',
                            maxLines: 9,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, color: defaultColor),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            ' الفريده من نوعها',
                            maxLines: 9,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, color: defaultColor),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: LoginScreen(),
                                    direction: AxisDirection.right,
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(defaultColor),
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
                                    vertical: 12, horizontal: 25),
                                child: Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              )),
                        ],
                      ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              )),
        );
      },
    );
  }
}
