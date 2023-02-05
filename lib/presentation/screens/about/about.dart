import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/color.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(fontFamily: 'F', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.mainColor,
        toolbarHeight: 120,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "APP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "F",
                              fontSize: 40),
                        ),
                      ),
                      const Divider(
                        color: Colors.blue,
                        thickness: 2,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 10,
                              height: 10,
                            ),
                            const Text(
                              "  Version: 0.1",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "F",
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 10,
                              height: 10,
                            ),
                            const Text(
                              "  App name: ...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "F",
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 10,
                              height: 10,
                            ),
                            const Text(
                              "  Release date: ...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "F",
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 10,
                              height: 10,
                            ),
                            const Text(
                              "  Developer: Amr Shserif",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "F",
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Special thanks for Mahmoud Khalifa for helping me",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "F", fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    const Center(
                      child: Text(
                        "FEEDBACK",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "F",
                            fontSize: 40),
                      ),
                    ),
                    const Divider(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                    const FittedBox(
                      child: Text(
                        "Report bugs and request features",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "F", fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri(
                          scheme: 'mailto',
                          path: 'amrsheif99@gmail.com',
                        ));
                      },
                      child: const FittedBox(
                        child: Text(
                          "amrsheif99@gmail.com",
                          style: TextStyle(
                              color: Colors.blue, fontFamily: "F", fontSize: 23,),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
