import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:king_app/presentation/widgets/service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../constants/color.dart';
import '../../../data/models/service_model.dart';
import '../../../data/helpers/firestore_helper.dart';

class ServiceList extends StatefulWidget {
  String type;
  String service;
  ServiceList({Key? key, required this.type, required this.service})
      : super(key: key);
  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  final controller = TextEditingController();

  Future<bool> checkInternetConnection() async {
    bool connected;
    connected = await InternetConnectionChecker().hasConnection;
    return connected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          widget.service,
          style: const TextStyle(fontFamily: 'F', fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.secColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {});
        },
        child: FutureBuilder<bool>(
          future: checkInternetConnection(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return FutureBuilder<ServiceListModel>(
                future: FireStoreHelper.instance
                    .getDocuments(widget.type, widget.service.toLowerCase()),
                builder: (BuildContext context,
                    AsyncSnapshot<ServiceListModel> snapshot) {
                  if (snapshot.data == null &&
                      snapshot.connectionState == ConnectionState.done) {
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
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data!.list.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Service(
                          index: index,
                          data: snapshot.data!.list[index],
                          type: widget.type,
                          service: widget.service,
                        );
                      },
                      itemCount: snapshot.data!.list.length,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: ColorConst.mainColor, size: 60),
                    );
                  } else {
                    return const Center(
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.all(80),
                          child: Text(
                            "No Services!",
                            style: TextStyle(
                                fontSize: 50,
                                fontFamily: 'F',
                                color: Colors.white),
                          ),
                        ),
                      ),
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
