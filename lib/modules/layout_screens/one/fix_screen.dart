import 'package:flutter/material.dart';

import '../../../constants/components.dart';
import '../../location/get_lat_long_address.dart';

class FixScreen extends StatelessWidget {
  const FixScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fixController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
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
                shadeMask('اوصف العطل',TextStyle(fontSize: 25)),
                const SizedBox(height: 30),
                defaultFormField(
                  controller: fixController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'اوصف العطل';
                    } else {
                      return null;
                    }
                  },
                  label: 'العطل',
                  prefix: Icons.car_rental,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetLatLongScreen(role: 'fix',),
                          ));
                    } else {
                      //FocusScope.of(context).unfocus();
                    }
                  },
                  child: Text('اضغط هنا'.toUpperCase(),
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
