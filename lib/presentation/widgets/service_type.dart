import 'package:flutter/material.dart';
import 'package:king_app/constants/string.dart';
import 'package:king_app/presentation/screens/home/sevice_list.dart';
import '../../constants/color.dart';

class ServiceType extends StatelessWidget {
  String service;
  String type;
  ServiceType({Key? key, required this.service, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.serviceListRoute,
              arguments: ServiceList(
                type: type,
                service: service,
              ),
            );
          },
          child: Material(
            elevation: 15,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            child: Container(
              height: 100,
              constraints: const BoxConstraints(minWidth: 100),
              decoration: BoxDecoration(
                  color: ColorConst.secColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: FittedBox(
                    child: Text(
                      service,
                      style: const TextStyle(
                          fontSize: 20, color: Colors.white, fontFamily: 'F'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        )
      ],
    );
  }
}
