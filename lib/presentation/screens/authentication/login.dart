import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/data/helpers/auth_helper.dart';
import 'package:king_app/presentation/widgets/text_field_builder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../constants/color.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: ColorConst.mainColor,
        statusBarColor: ColorConst.secColor));
    super.initState();
  }

  final usernameCon = TextEditingController();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();

  Icon hideText = const Icon(Icons.visibility_off_outlined);
  Icon showText = const Icon(Icons.visibility_outlined);
  late Icon icon = const Icon(Icons.visibility_off_outlined);
  bool obscureText = true;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              const FittedBox(
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      fontFamily: 'F', fontSize: 35, color: Colors.white),
                ),
              ),
              const SizedBox(),
              Column(
                children: [
                  TextFieldBuilder(
                      hint: "Enter your E-mail",
                      label: "E-mail",
                      controller: emailCon,
                      iconData: Icons.email),
                  const SizedBox(
                    height: 30,
                  ),
                  ObscureTextFieldBuilder(
                      controller: passwordCon,
                      obscureText: obscureText,
                      icon: icon,
                      label: "Password",
                      hint: "Enter your password",
                      iconData: Icons.password)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: loading == false
                        ? MaterialButton(
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              AuthenticationHelper.instance
                                  .emailLogin(context, passwordCon, emailCon)
                                  .then((value) => setState(() {
                                        loading = false;
                                      }));
                            },
                            minWidth: double.infinity,
                            height: 50,
                            color: Colors.white,
                            elevation: 5,
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(
                                  fontFamily: 'F',
                                  fontSize: 20,
                                  color: Colors.blue),
                            ))
                        : LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white, size: 50),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FittedBox(
                        child: Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                              fontFamily: 'F',
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                      FittedBox(
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .clearMaterialBanners();
                            Navigator.pushReplacementNamed(
                                context, Routes.signUpRoute);
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontFamily: 'F',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
