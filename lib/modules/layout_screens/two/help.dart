import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../../constants/components.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fixController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                shadeMask(' ما هي  مقترحاتك', TextStyle(fontSize: 25)),
                const SizedBox(height: 30),
                defaultFormField(
                  controller: fixController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'ما هي مقترحاتك ';
                    } else {
                      return null;
                    }
                  },
                  label: 'كيف نقوم بمساعدتك ',
                  prefix: Icons.car_rental,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                      MotionToast.success(
                        description: Text(
                          'تم الارسال بنجاح',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                        animationType: AnimationType.fromLeft,
                        position: MotionToastPosition.bottom,
                        width: 300,
                        height: 100,
                      ).show(context);
                    } else {
                      
                    }
                  },
                  child: Text('اضغط'.toUpperCase(),
                      style:
                     TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
