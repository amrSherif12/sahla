import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/data/helpers/auth_helper.dart';
import 'package:king_app/presentation/widgets/text_field_builder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../constants/color.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: ColorConst.mainColor,
        statusBarColor: ColorConst.secColor));
    super.initState();
  }

  final nameCon = TextEditingController();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final passwordConfirmCon = TextEditingController();

  late Icon icon = const Icon(Icons.visibility_off_outlined);
  late Icon confIcon = const Icon(Icons.visibility_off_outlined);
  bool obscureText = true;
  bool confirmObscureText = true;

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Sign up",
                  style: TextStyle(
                      fontFamily: 'F', fontSize: 35, color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFieldBuilder(
                        controller: nameCon,
                        label: "User name",
                        hint: "Enter your name",
                        iconData: Icons.person,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldBuilder(
                        controller: emailCon,
                        label: "E-mail",
                        hint: "Enter your E-mail",
                        iconData: Icons.email,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ObscureTextFieldBuilder(
                        controller: passwordCon,
                        obscureText: obscureText,
                        icon: icon,
                        label: "Password",
                        hint: "Enter your password",
                        iconData: Icons.password,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ObscureTextFieldBuilder(
                        controller: passwordConfirmCon,
                        obscureText: confirmObscureText,
                        icon: confIcon,
                        label: "Confirm password",
                        hint: "Confirm your password",
                        iconData: Icons.password,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      loading == false
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  AuthenticationHelper.instance
                                      .emailSignUp(context, passwordCon,
                                          emailCon, passwordConfirmCon, nameCon)
                                      .then(
                                        (value) => setState(
                                          () {
                                            loading = false;
                                          },
                                        ),
                                      );
                                },
                                minWidth: double.infinity,
                                height: 50,
                                color: Colors.white,
                                elevation: 5,
                                padding: const EdgeInsets.all(20),
                                child: const Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                      fontFamily: 'F',
                                      fontSize: 20,
                                      color: Colors.blue),
                                ),
                              ),
                            )
                          : LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.white, size: 50),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account ? ",
                      style: TextStyle(
                          fontFamily: 'F', fontSize: 18, color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontFamily: 'F',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
