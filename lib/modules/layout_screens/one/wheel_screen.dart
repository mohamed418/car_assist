import 'package:flutter/material.dart';

class WheelScreen extends StatelessWidget {
  const WheelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('wheel'),
          ],
        ),
      ),
    );
  }
}
