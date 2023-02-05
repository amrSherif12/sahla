import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  String img;
  String name;

  ServiceModel({required this.id, required this.img, required this.name});

  factory ServiceModel.fromSnapshot(QueryDocumentSnapshot document) {
    return ServiceModel(
        id: document.id, img: document["img_url"], name: document["name"]);
  }
}

class ServiceListModel {
  List<ServiceModel> list;

  ServiceListModel({required this.list});
}
