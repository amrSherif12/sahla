import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:king_app/data/helpers/auth_helper.dart';
import '../../data/models/service_details_model.dart';
import '../../data/models/service_model.dart';

class FireStoreHelper {
  FireStoreHelper._privateConstructor();

  static final FireStoreHelper _instance =
      FireStoreHelper._privateConstructor();

  static FireStoreHelper get instance => _instance;
  final ins = FirebaseFirestore.instance;

  Future<ServiceDetailsModel> getDocument(
      String type, String service, String id) async {
    final uid = AuthenticationHelper.instance.auth.currentUser!.uid;
    final name = AuthenticationHelper.instance.auth.currentUser!.displayName;

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await ins
        .collection("services")
        .doc(type)
        .collection("types")
        .doc(service)
        .collection("services")
        .doc(id)
        .get();

    ServiceDetailsModel doc =
        ServiceDetailsModel.fromSnapshot(documentSnapshot, uid, name!);
    return doc;
  }

  Future<ServiceListModel> getDocuments(String type, String service) async {
    QuerySnapshot querySnapshot = await ins
        .collection("services")
        .doc(type)
        .collection("types")
        .doc(service)
        .collection("services")
        .get();

    List<ServiceModel> docs = querySnapshot.docs
        .map((doc) => ServiceModel.fromSnapshot(doc))
        .toList();

    return ServiceListModel(list: docs);
  }

  void addReview(String type, String service, String id, String review,
      double stars, BuildContext context) {
    final uid = AuthenticationHelper.instance.auth.currentUser!.uid;
    final name =
        AuthenticationHelper.instance.auth.currentUser!.displayName ?? "";
    if (stars > 0) {
      ins
          .collection("services")
          .doc(type)
          .collection("types")
          .doc(service)
          .collection("services")
          .doc(id)
          .set(
        {
          "reviews": {
            uid: {
              'uid': uid,
              'name': name,
              'review': review,
              'stars': stars,
            }
          }
        },
        SetOptions(merge: true),
      );

      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Give a rating",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 13.0,
      );
    }
  }

  Future<bool> isAdmin(String uid) async {
    bool isAdmin = false;
    DocumentSnapshot snapshot =
        await ins.collection("authentication").doc("admins").get();
    String admins = snapshot["admins"][uid] ?? "";
    if (admins == uid) {
      isAdmin = true;
    }
    return isAdmin;
  }
}
