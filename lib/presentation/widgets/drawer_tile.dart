import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubits/drawer_cubit.dart';

Widget drawerItem(
    String title, IconData icon, int index, BuildContext context) {
  return ListTile(
    onTap: () {
      if (index == 0) {
        BlocProvider.of<DrawerCubit>(context).goToHome();
      } else if (index == 1) {
        BlocProvider.of<DrawerCubit>(context).goToOffers();
      } else if (index == 2) {
        BlocProvider.of<DrawerCubit>(context).goToProfile();
      } else if (index == 3) {
        BlocProvider.of<DrawerCubit>(context).goToAbout();
      }
    },
    minLeadingWidth: 20,
    iconColor: Colors.white,
    textColor: Colors.white,
    leading: Icon(
      icon,
    ),
    title: Text(
      title,
      style: const TextStyle(fontFamily: "F", fontSize: 20),
    ),
  );
}
