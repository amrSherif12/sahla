import 'dart:async';
import 'package:king_app/constants/color.dart';
import 'package:king_app/constants/string.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void navigation() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loggedIn = prefs.getString("loggedIn");

    if (loggedIn == "no" || loggedIn == null) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.drawerRoute);
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: ColorConst.mainColor,
        statusBarColor: ColorConst.secColor));
    navigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConst.secColor, ColorConst.mainColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Loading",
                style: TextStyle(
                    color: Colors.white, fontSize: 35, fontFamily: 'F'),
              ),
              const SizedBox(
                height: 30,
              ),
              LoadingAnimationWidget.discreteCircle(
                  color: Colors.white, size: 50)
            ],
          ),
        ),
      ),
    );
  }
}
