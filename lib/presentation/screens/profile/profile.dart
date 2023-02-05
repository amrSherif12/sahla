import 'package:flutter/material.dart';
import 'package:king_app/constants/color.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/data/models/user_model.dart';
import 'package:king_app/data/helpers/auth_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: 'F', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.mainColor,
        toolbarHeight: 120,
      ),
      body: FutureBuilder(
        future: AuthenticationHelper.instance.getUserCredential(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "User name:  ",
                                style: TextStyle(
                                    fontFamily: 'F',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                    fontFamily: 'F',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Email:  ",
                                style: TextStyle(
                                    fontFamily: 'F',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                snapshot.data!.email,
                                style: const TextStyle(
                                    fontFamily: 'F',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      onPressed: () {
                        AuthenticationHelper.instance.logout(context);
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      color: ColorConst.mainColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "LOG OUT",
                          style: TextStyle(
                              fontFamily: 'F',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: ColorConst.mainColor, size: 60),
            );
          }
        },
      ),
    );
  }
}
