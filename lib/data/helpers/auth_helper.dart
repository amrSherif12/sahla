// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/string.dart';
import '../../data/models/user_model.dart';
import '../../presentation/widgets/banner_builder.dart';

class AuthenticationHelper {
  AuthenticationHelper._privateConstructor();

  static final AuthenticationHelper _instance =
      AuthenticationHelper._privateConstructor();

  static AuthenticationHelper get instance => _instance;
  final auth = FirebaseAuth.instance;

  Future<void> emailLogin(BuildContext context, TextEditingController passwordCon,
      TextEditingController emailCon) async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    if (passwordCon.text.isEmpty || emailCon.text.isEmpty) {
      bannerBuilder(
          Colors.red,
          "Fill all the fields",
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          context);
    } else if (!EmailValidator.validate(emailCon.text.trim())) {
      bannerBuilder(
          Colors.red,
          "Incorrect email format",
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          context);
    } else {
      try {
        await auth
            .signInWithEmailAndPassword(
                email: emailCon.text.trim(), password: passwordCon.text.trim())
            .then(
          (value) {
            ScaffoldMessenger.of(context).clearMaterialBanners();
            Fluttertoast.showToast(
              msg: "Signed in successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 13.0,
            );
            Navigator.pushReplacementNamed(context, Routes.drawerRoute);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          bannerBuilder(
              Colors.red,
              "User not found",
              const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              context);
        } else if (e.code == 'wrong-password') {
          bannerBuilder(
              Colors.red,
              "Wrong password",
              const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              context);
        }
      }
    }
  }

  Future<void> emailSignUp(
      BuildContext context,
      TextEditingController passwordCon,
      TextEditingController emailCon,
      TextEditingController passwordConfirmCon,
      TextEditingController nameCon) async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    if (passwordCon.text.isEmpty ||
        emailCon.text.isEmpty ||
        passwordConfirmCon.text.isEmpty ||
        nameCon.text.isEmpty) {
      bannerBuilder(
          Colors.red,
          "Fill all the fields",
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          context);
    } else if (!EmailValidator.validate(emailCon.text.trim())) {
      bannerBuilder(
          Colors.red,
          "Incorrect email format",
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          context);
    } else if (!hasSpace(nameCon.text.trim())) {
      bannerBuilder(
          Colors.red,
          "Enter full name",
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          context);
    } else {
      if (passwordCon.text.trim() == passwordConfirmCon.text.trim()) {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailCon.text.trim(),
            password: passwordCon.text.trim(),
          );
          userCredential.user!.updateDisplayName(nameCon.text.trim());
          await auth
              .signInWithEmailAndPassword(
                  email: emailCon.text.trim(),
                  password: passwordCon.text.trim())
              .then(
            (value) async {
              ScaffoldMessenger.of(context).clearMaterialBanners();
              Fluttertoast.showToast(
                msg: "Account created successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 13.0,
              );
              Navigator.pushReplacementNamed(context, Routes.drawerRoute);
            },
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            bannerBuilder(
                Colors.red,
                "Password can't be less than 6 characters",
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                context);
          } else if (e.code == 'email-already-in-use') {
            bannerBuilder(
                Colors.red,
                "Email already in use",
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                context);
          }
        } catch (e) {
          bannerBuilder(
              Colors.red,
              "An unknown error occurred",
              const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              context);
        }
      } else {
        bannerBuilder(
            Colors.red,
            "The password confirmation doesn't match the password",
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            context);
      }
    }
  }

  void logout(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    auth.signOut();

    await pref.setString("userName", "");
    await pref.setString("userID", "");
    await pref.setString("email", "");

    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  Future<UserModel> getUserCredential() async {
    final auth = FirebaseAuth.instance;

    UserModel user = UserModel(
        uid: auth.currentUser!.uid,
        name: auth.currentUser!.displayName!,
        email: auth.currentUser!.email!);

    return user;
  }
}

bool hasSpace(String string) {
  for (int i = 0; i < string.length; i++) {
    if (string[i] == " ") {
      return true;
    }
  }
  return false;
}
