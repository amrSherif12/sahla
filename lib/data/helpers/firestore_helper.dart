import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:king_app/data/models/review_model.dart';
import 'package:king_app/data/helpers/auth_helper.dart';

import '../../data/models/service_details_model.dart';
import '../../data/models/service_model.dart';

class FireStoreHelper {
  FireStoreHelper._privateConstructor();

  static final FireStoreHelper _instance =
  FireStoreHelper._privateConstructor();

  static FireStoreHelper get instance => _instance;
  final ins = FirebaseFirestore.instance;

  Future<ServiceDetailsModel> getDocument(String type, String service,
      String id) async {
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
      double stars) {
    final uid = AuthenticationHelper.instance.auth.currentUser!.uid;
    final name =
        AuthenticationHelper.instance.auth.currentUser!.displayName ?? "";

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
  }
}