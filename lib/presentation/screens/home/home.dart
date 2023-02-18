import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:king_app/constants/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:king_app/logic/cubits/nav_bar_cubit.dart';
import 'package:king_app/logic/cubits/nav_bar_state.dart';
import '../../widgets/service_type.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: ColorConst.secColor,
        statusBarColor: Colors.transparent));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)),
                child: Image.asset(
                  "assets/imgs/villa.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: IconButton(
                          onPressed: () {
                            ZoomDrawer.of(context)!.toggle();
                          },
                          icon: const Icon(
                            Icons.menu,
                            size: 35,
                            color: Colors.white,
                          ),
                          splashRadius: 10,
                        ),
                      ),
                      const FittedBox(
                        child: Text(
                          "Sahla",
                          style: TextStyle(
                              fontFamily: 'F',
                              color: Colors.white,
                              fontSize: 35),
                        ),
                      ),
                      const SizedBox(
                        width: 45,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              if (state is NavBarMedFood) {
                return Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Medical",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Hospital',
                              type: "medical",
                            ),
                            ServiceType(
                              service: 'Pharmacy',
                              type: "medical",
                            ),
                            ServiceType(
                              service: 'Veterinarian',
                              type: "medical",
                            ),
                            ServiceType(
                              service: 'Clinic',
                              type: "medical",
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Food",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Restaurants',
                              type: "food",
                            ),
                            ServiceType(
                              service: 'SuperMarket',
                              type: "food",
                            ),
                            ServiceType(
                              service: 'Animal Products',
                              type: "food",
                            ),
                            ServiceType(
                              service: 'Fish',
                              type: "food",
                            ),
                            ServiceType(
                              service: 'Fruits & vegetables',
                              type: "food",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is NavBarHomeFun) {
                return Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Home Maintenance",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Carpenter',
                              type: "home maintenance",
                            ),
                            ServiceType(
                              service: 'Electrician',
                              type: "home maintenance",
                            ),
                            ServiceType(
                              service: 'Plumber',
                              type: "home maintenance",
                            ),
                            ServiceType(
                              service: 'Home Cleaning',
                              type: "home maintenance",
                            ),
                            ServiceType(
                              service: 'Pest Control',
                              type: "home maintenance",
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Entertainment",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Mall',
                              type: "entertainment",
                            ),
                            ServiceType(
                              service: 'Amusement Park',
                              type: "entertainment",
                            ),
                            ServiceType(
                              service: 'Event Hall',
                              type: "entertainment",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is NavBarRESport) {
                return Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Real Estate",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Compound (villas)',
                              type: "real estate",
                            ),
                            ServiceType(
                              service: 'Compound (apartments)',
                              type: "real estate",
                            ),
                            ServiceType(
                              service: 'Hotel',
                              type: "real estate",
                            ),
                            ServiceType(
                              service: 'Land for rent',
                              type: "real estate",
                            ),
                            ServiceType(
                              service: 'villas for rent',
                              type: "real estate",
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Sport",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Club',
                              type: "sport",
                            ),
                            ServiceType(
                              service: 'Sport Academy',
                              type: "sport",
                            ),
                            ServiceType(
                              service: 'Gym',
                              type: "sport",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is NavBarEducOthers) {
                return Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Education",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'School',
                              type: "education",
                            ),
                            ServiceType(
                              service: 'Institute',
                              type: "education",
                            ),
                            ServiceType(
                              service: 'College',
                              type: "education",
                            ),
                            ServiceType(
                              service: 'Nursery',
                              type: "education",
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Others",
                        style: TextStyle(
                            fontFamily: 'F', color: Colors.white, fontSize: 25),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ServiceType(
                              service: 'Bank',
                              type: "others",
                            ),
                            ServiceType(
                              service: 'Plant Shop',
                              type: "others",
                            ),
                            ServiceType(
                              service: 'Animal Shop',
                              type: "others",
                            ),
                            ServiceType(
                              service: 'Dry Clean',
                              type: "others",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: FittedBox(
        child: GNav(
          gap: 5,
          tabBackgroundColor: ColorConst.mainColor,
          backgroundColor: ColorConst.secColor,
          padding: const EdgeInsets.all(25),
          onTabChange: (index) {
            if (index == 0) {
              BlocProvider.of<NavBarCubit>(context).goToMedFun();
            } else if (index == 1) {
              BlocProvider.of<NavBarCubit>(context).goToHomeFun();
            } else if (index == 2) {
              BlocProvider.of<NavBarCubit>(context).goToRESport();
            } else if (index == 3) {
              BlocProvider.of<NavBarCubit>(context).goToEducOthers();
            }
          },
          textStyle: const TextStyle(fontFamily: "F", color: Colors.white),
          tabs: const [
            GButton(
              icon: Icons.article_rounded,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: "Medical & Food",
            ),
            GButton(
              icon: Icons.article_rounded,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: "Home & Fun",
            ),
            GButton(
              icon: Icons.article_rounded,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: "RE & Sport",
            ),
            GButton(
              icon: Icons.article_rounded,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: "Education & Others",
            ),
          ],
        ),
      ),
    );
  }
}
