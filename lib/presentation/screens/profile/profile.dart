import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:king_app/constants/color.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/data/helpers/firestore_helper.dart';
import 'package:king_app/data/models/user_model.dart';
import 'package:king_app/data/helpers/auth_helper.dart';
import 'package:king_app/logic/cubits/notification_mode_cubit.dart';
import 'package:king_app/presentation/widgets/text_field_builder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String uid;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: 'F', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.secColor,
        toolbarHeight: 120,
      ),
      body: FutureBuilder(
        future: AuthenticationHelper.instance.getUserCredential(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            uid = snapshot.data!.uid;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
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
                  ),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: FireStoreHelper.instance.isAdmin(uid),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.data == true &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Notifications",
                                style: TextStyle(
                                    fontFamily: 'F',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldBuilder(
                                  hint: '',
                                  label: 'Enter the offer or service name',
                                  controller: controller,
                                  iconData: Icons.search),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<NotificationModeCubit>(
                                              context)
                                          .service();
                                    },
                                    child: BlocBuilder<NotificationModeCubit,
                                            NotificationModeState>(
                                        builder: (context, state) {
                                      if (state is NotificationModeService) {
                                        return const Text(
                                          "Service",
                                          style: TextStyle(
                                              fontFamily: 'F',
                                              fontSize: 20,
                                              color: Colors.lightBlue,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return const Text(
                                          "Service",
                                          style: TextStyle(
                                              fontFamily: 'F',
                                              fontSize: 20,
                                              color: Colors.white),
                                        );
                                      }
                                    }),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<NotificationModeCubit>(
                                              context)
                                          .offer();
                                    },
                                    child: BlocBuilder<NotificationModeCubit,
                                        NotificationModeState>(
                                      builder: (context, state) {
                                        if (state is NotificationModeOffer) {
                                          return const Text(
                                            "Offer",
                                            style: TextStyle(
                                                fontFamily: 'F',
                                                fontSize: 20,
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          return const Text(
                                            "Offer",
                                            style: TextStyle(
                                                fontFamily: 'F',
                                                fontSize: 20,
                                                color: Colors.white),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: ColorConst.mainColor,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Send notification",
                                      style: TextStyle(
                                          fontFamily: 'F',
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
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
