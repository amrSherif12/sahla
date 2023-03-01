import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:king_app/data/models/review_model.dart';
import 'package:king_app/data/models/service_model.dart';
import 'package:king_app/data/models/stars_model.dart';

class ServiceDetailsModel extends ServiceModel {
  ServiceDetailsModel(
      {required String id,
      required String img,
      required String name,
      required this.phoneNumber,
      required this.reviews,
      required this.location,
      required this.averageRating,
      required this.userReview,
       required this.starsCount,
      required this.textReviews,
      required this.facebook,
      required this.instagram,
      required this.whatsapp,
      })
      : super(id: id, img: img, name: name);

  String phoneNumber;
  GeoPoint location;
  List<ReviewModel> reviews;
  double averageRating;
  ReviewModel userReview;
  StarsModel starsCount;
  List<ReviewModel> textReviews;
  String instagram;
  String facebook;
  String whatsapp;

  factory ServiceDetailsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document,
      String uid,
      String name) {
    final data = document.data()!;
    final reviews = ReviewsModel.fromMap(data["reviews"]);
    return ServiceDetailsModel(
      id: document.id,
      img: data["img_url"],
      name: data["name"],
      phoneNumber: data["number"],
      location: data["location"],
      instagram: data["instagram"],
      facebook: data["facebook"],
      whatsapp: data["whatsapp"],
      reviews: reviews,
      averageRating: ReviewsModel.getAverageRating(reviews),
      userReview: ReviewsModel.getUserReview(reviews, uid, name),
      starsCount: ReviewsModel.getStarsCount(reviews),
      textReviews: ReviewsModel.getTextReviews(reviews),
    );
  }
}
