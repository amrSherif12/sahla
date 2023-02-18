import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/data/models/service_details_model.dart';
import 'package:king_app/data/helpers/firestore_helper.dart';
import 'package:king_app/presentation/screens/home/review_page.dart';
import 'package:king_app/presentation/screens/home/see_all_reviews.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:king_app/presentation/widgets/review_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/color.dart';

class InfoPage extends StatefulWidget {
  String type;
  String service;
  String id;
  InfoPage(
      {Key? key, required this.type, required this.service, required this.id})
      : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  double rating = 0;

  Future<bool> checkInternetConnection() async {
    bool connected;
    connected = await InternetConnectionChecker().hasConnection;
    return connected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {});
        },
        child: FutureBuilder<bool>(
          future: checkInternetConnection(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return FutureBuilder<ServiceDetailsModel>(
                future: FireStoreHelper.instance.getDocument(
                    widget.type, widget.service.toLowerCase(), widget.id),
                builder: (BuildContext context,
                    AsyncSnapshot<ServiceDetailsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<ServiceStars> chartData = [
                      ServiceStars(
                          "1 Star", snapshot.data!.starsCount.oneStars),
                      ServiceStars(
                          "2 Stars", snapshot.data!.starsCount.twoStars),
                      ServiceStars(
                          "3 Stars", snapshot.data!.starsCount.threeStars),
                      ServiceStars(
                          "4 Stars", snapshot.data!.starsCount.fourStars),
                      ServiceStars(
                          "5 Stars", snapshot.data!.starsCount.fiveStars),
                    ];
                    return Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35)),
                              child: snapshot.data!.img == "null"
                                  ? Column(
                                      children: const [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: FittedBox(
                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              size: 170,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: snapshot.data!.img,
                                      placeholder: (context, img) {
                                        return Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFEBEBF4),
                                                Color(0xFFF4F4F4),
                                                Color(0xFFEBEBF4),
                                              ],
                                              stops: [
                                                0.1,
                                                0.3,
                                                0.4,
                                              ],
                                              begin: Alignment(-1.0, -0.3),
                                              end: Alignment(1.0, 0.3),
                                              tileMode: TileMode.clamp,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      splashRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                children: [
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 100),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_android,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              SelectableText(
                                                snapshot.data!.phoneNumber,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'F',
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  snapshot.data!.name,
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'F',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 30,
                                          thickness: 2,
                                          color: Colors.grey[800],
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 200),
                                    child: Column(
                                      children: [
                                        FittedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: GestureDetector(
                                                        onTap: () async {
                                                          await launchUrl(
                                                            Uri(
                                                                scheme: 'https',
                                                                host:
                                                                    'www.instagram.com',
                                                                path: snapshot
                                                                    .data!
                                                                    .instagram),
                                                            mode: LaunchMode
                                                                .externalNonBrowserApplication,
                                                          );
                                                        },
                                                        child: Image.asset(
                                                            'assets/imgs/instaLogo.png')),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 44,
                                                    height: 44,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: GestureDetector(
                                                          onTap: () async {
                                                            await launchUrl(
                                                              Uri(
                                                                  scheme:
                                                                      'https',
                                                                  host:
                                                                      'www.facebook.com',
                                                                  path: snapshot
                                                                      .data!
                                                                      .facebook),
                                                              mode: LaunchMode
                                                                  .externalApplication,
                                                            );
                                                          },
                                                          child: Image.asset(
                                                              'assets/imgs/facebookLogo.png')),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 44,
                                                    height: 44,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      child: GestureDetector(
                                                          onTap: () async {
                                                            await launchUrl(
                                                              Uri(
                                                                  scheme: 'tel',
                                                                  path: snapshot
                                                                      .data!
                                                                      .phoneNumber),
                                                              mode: LaunchMode
                                                                  .externalNonBrowserApplication,
                                                            );
                                                          },
                                                          child: Image.asset(
                                                              'assets/imgs/dial.png')),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 44,
                                                    height: 44,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      child: GestureDetector(
                                                          onTap: () async {
                                                            await launchUrl(
                                                              Uri(
                                                                  scheme:
                                                                      'https',
                                                                  host: 'wa.me',
                                                                  path: snapshot
                                                                      .data!
                                                                      .phoneNumber),
                                                              mode: LaunchMode
                                                                  .externalNonBrowserApplication,
                                                            );
                                                          },
                                                          child: Image.asset(
                                                              'assets/imgs/whatsapp.jpeg')),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 30,
                                          thickness: 2,
                                          color: Colors.grey[800],
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 300),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: TextButton(
                                            onPressed: () {
                                              MapsLauncher.launchCoordinates(
                                                snapshot
                                                    .data!.location.latitude,
                                                snapshot
                                                    .data!.location.longitude,
                                              );
                                            },
                                            child: const Text(
                                              "Show location on map",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'F',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 30,
                                          thickness: 2,
                                          color: Colors.grey[800],
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 400),
                                    child: Column(
                                      children: [
                                        const Center(
                                          child: Text(
                                            "Your rating",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'F',
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RatingBar.builder(
                                          initialRating:
                                              snapshot.data!.userReview.stars,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          ignoreGestures: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.blue,
                                          ),
                                          unratedColor: Colors.blueGrey,
                                          onRatingUpdate: (double value) {
                                            rating = value;
                                            Navigator.pushNamed(
                                              context,
                                              Routes.reviewPageRoute,
                                              arguments: ReviewPage(
                                                name: snapshot.data!.name,
                                                id: widget.id,
                                                service: widget.service,
                                                type: widget.type,
                                                review:
                                                    snapshot.data!.userReview,
                                              ),
                                            );
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.reviewPageRoute,
                                              arguments: ReviewPage(
                                                name: snapshot.data!.name,
                                                id: widget.id,
                                                service: widget.service,
                                                type: widget.type,
                                                review:
                                                    snapshot.data!.userReview,
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Give your review",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'F',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 500),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Ratings and reviews",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: 'F',
                                              color: Colors.white),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Rating",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'F',
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    snapshot.data!.averageRating
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        fontSize: 60,
                                                        fontFamily: 'F',
                                                        color: Colors.white),
                                                  ),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.blue,
                                                    size: 65,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  SfCircularChart(
                                                    palette: [
                                                      Colors.blue[100]!,
                                                      Colors.blue[300]!,
                                                      Colors.blue[500]!,
                                                      Colors.blue[700]!,
                                                      Colors.blue[900]!
                                                    ],
                                                    legend: Legend(
                                                        isVisible: true,
                                                        shouldAlwaysShowScrollbar:
                                                            true,
                                                        overflowMode:
                                                            LegendItemOverflowMode
                                                                .scroll,
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'F')),
                                                    series: <CircularSeries>[
                                                      DoughnutSeries<
                                                              ServiceStars,
                                                              String>(
                                                          dataSource: chartData,
                                                          strokeColor:
                                                              Colors.white,
                                                          strokeWidth: 1,
                                                          xValueMapper:
                                                              (ServiceStars
                                                                          data,
                                                                      _) =>
                                                                  data.stars,
                                                          yValueMapper:
                                                              (ServiceStars
                                                                          data,
                                                                      _) =>
                                                                  data.amount,
                                                          animationDuration:
                                                              4000,
                                                          enableTooltip: true)
                                                    ],
                                                    tooltipBehavior:
                                                        TooltipBehavior(
                                                            enable: true,
                                                            elevation: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 600),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final review = snapshot
                                                .data!.textReviews[index];
                                            return ReviewBuilder(
                                              name: review.userName,
                                              rating: review.stars,
                                              review: review.review,
                                              blueBack: false,
                                            );
                                          },
                                          itemCount: snapshot.data!.textReviews
                                                      .length >
                                                  3
                                              ? 3
                                              : snapshot
                                                  .data!.textReviews.length,
                                        ),
                                        snapshot.data!.textReviews.length > 3
                                            ? TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.seeAllReviewsRoute,
                                                    arguments: SeeAllReviews(
                                                        reviews: snapshot
                                                            .data!.textReviews),
                                                  );
                                                },
                                                child: const Text(
                                                  "See all reviews",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'F',
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: ColorConst.mainColor, size: 60),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 70,
                          color: Colors.white,
                        ),
                        const FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              "Something went wrong!",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'F',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 40,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            const FittedBox(
                              child: Text(
                                "go back",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'F',
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                },
              );
            } else if (snapshot.data == false) {
              return Center(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(80),
                    child: Column(
                      children: [
                        const Text(
                          "No Internet!",
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'F',
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  size: 40,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "refresh",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'F',
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
      ),
    );
  }
}

class ServiceStars {
  String stars;
  int amount;
  ServiceStars(this.stars, this.amount);
}
