import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:king_app/logic/cubits/nav_bar_cubit.dart';
import 'package:king_app/presentation/screens/drawer.dart';
import 'package:king_app/presentation/screens/home/home.dart';
import 'package:king_app/presentation/screens/home/offers.dart';
import 'package:king_app/presentation/screens/home/review_page.dart';
import 'package:king_app/presentation/screens/home/see_all_reviews.dart';
import 'package:king_app/presentation/screens/loading_screen.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/presentation/screens/authentication/login.dart';
import 'package:king_app/presentation/screens/home/service_info.dart';
import 'package:king_app/presentation/screens/home/sevice_list.dart';
import 'package:king_app/presentation/screens/authentication/sign_up.dart';
import 'package:king_app/presentation/screens/undefined_screen.dart';
import 'package:king_app/presentation/screens/unsupported_platform.dart';
import 'package:page_transition/page_transition.dart';
import 'logic/cubits/drawer_cubit.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.loadingScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoadingScreen());

    case Routes.homeRoute:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (BuildContext context) => NavBarCubit(),
              child: const Home()));

    case Routes.loginRoute:
      return MaterialPageRoute(
        builder: (context) => const Login(),
      );

    case Routes.signUpRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUp(),
      );

    case Routes.serviceInfoRoute:
      final args = settings.arguments as InfoPage;
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        child: InfoPage(
          type: args.type,
          service: args.service,
          id: args.id,
        ),
      );

    case Routes.serviceListRoute:
      final args = settings.arguments as ServiceList;
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        child: ServiceList(
          type: args.type,
          service: args.service,
        ),
      );

    case Routes.drawerRoute:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (BuildContext context) => DrawerCubit(),
            child: const AppDrawer()),
      );

    case Routes.reviewPageRoute:
      final args = settings.arguments as ReviewPage;
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        child: ReviewPage(
          name: args.name,
          service: args.service,
          type: args.type,
          id: args.id,
          review: args.review,
        ),
      );

    case Routes.seeAllReviewsRoute:
      final args = settings.arguments as SeeAllReviews;
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        child: SeeAllReviews(
          reviews: args.reviews,
        ),
      );

    case Routes.offersRoute:
      return MaterialPageRoute(
        builder: (context) => const Offers(),
      );

    case Routes.unsupportedPlatformRoute:
      return MaterialPageRoute(
        builder: (context) => const UnsupportedPlatform(),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Undefined());
  }
}
