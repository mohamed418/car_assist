import 'package:flutter/material.dart';

import '../../../constants/components.dart';
import '../../location/get_lat_long_address.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

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
                shadeMask('  ما هي نوع المساعده التي تحتاجها؟',TextStyle(fontSize: 25)),
                const SizedBox(height: 30),
                defaultFormField(
                  controller: fixController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'ما هي نوع المساعده التي تحتاجها؟';
                    } else {
                      return null;
                    }
                  },
                  label: 'ما هي  المشكله',
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
                            builder: (context) => const GetLatLongScreen(role: 'other',),
                          ));
                    } else {
                    }
                  },
                  child: Text('قم بالضغط هنــا'.toUpperCase(),
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
