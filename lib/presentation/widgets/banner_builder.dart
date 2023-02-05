import 'package:flutter/material.dart';

void bannerBuilder(Color color, String text, Icon icon, BuildContext context) {
  ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
    content: Text(
      text,
      style: const TextStyle(color: Colors.white, fontFamily: 'F'),
    ),
    leading: icon,
    backgroundColor: color,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).clearMaterialBanners();
        },
        icon: const Icon(Icons.close),
        color: Colors.white,
      )
    ],
  ));
}
