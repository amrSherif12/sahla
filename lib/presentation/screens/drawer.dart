import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:king_app/constants/color.dart';
import 'package:king_app/logic/cubits/drawer_cubit.dart';
import 'package:king_app/logic/cubits/drawer_state.dart';
import 'package:king_app/presentation/screens/about/about.dart';
import 'package:king_app/presentation/screens/profile/profile.dart';
import 'package:king_app/presentation/screens/undefined_screen.dart';
import 'package:king_app/presentation/widgets/drawer_tile.dart';
import '../../logic/cubits/nav_bar_cubit.dart';
import 'home/home.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: ColorConst.mainColor,
      style: DrawerStyle.defaultStyle,
      menuScreen: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            drawerItem("Home", Icons.home, 0, context),
            drawerItem("Profile", Icons.person, 1, context),
            drawerItem("About", Icons.info, 2, context),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      mainScreen: BlocBuilder<DrawerCubit, DrawerState_>(
        builder: (context, state) {
          if (state is DrawerHome) {
            return BlocProvider(
                create: (BuildContext context) => NavBarCubit(),
                child: const Home());
          } else if (state is DrawerProfile) {
            return const Profile();
          } else if (state is DrawerAbout) {
            return const About();
          } else {
            return const Undefined();
          }
        },
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      androidCloseOnBackTap: true,
      drawerShadowsBackgroundColor: Colors.blue,
      shadowLayer1Color: ColorConst.secColor,
      openCurve: Curves.decelerate,
      closeCurve: Curves.decelerate,
    );
  }
}
