import 'package:flutter/material.dart';

import '../../constants/color.dart';

class Undefined extends StatelessWidget {
  const Undefined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConst.secColor,
              ColorConst.mainColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Text(
            "Undefined screen",
            style:
                TextStyle(fontFamily: 'F', fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
