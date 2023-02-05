import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:king_app/constants/color.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/presentation/screens/home/service_info.dart';

class Service extends StatelessWidget {
  String type;
  String service;
  final data;
  Service(
      {Key? key, required this.service, required this.type, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.serviceInfoRoute,
                    arguments:
                        InfoPage(type: type, service: service, id: data.id));
              },
              child: data.img != null
                  ? CachedNetworkImage(
                      imageUrl: data.img,
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
                    )
                  : Image.asset("assets/imgs/unavailable.png"),
            ),
          ),
        ),
         Divider(
          height: 20,
          endIndent: 80,
          indent: 80,
          thickness: 3,
          color: ColorConst.mainColor,
        ),
        Text(
          data.name,
          style: const TextStyle(fontSize: 25, fontFamily: 'F', color: Colors.white),
        ),
         Divider(
          height: 20,
          endIndent: 80,
          indent: 80,
          thickness: 3,
          color: ColorConst.mainColor,
        ),
      ],
    );
  }
}
