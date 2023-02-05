import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:king_app/data/models/stars_model.dart';

class ReviewsModel {
  List<ReviewModel> reviews;

  ReviewsModel({
    required this.reviews,
  });

  static double getAverageRating(List<ReviewModel> reviews) {
    double rating = 0;
    for (int i = 0; i < reviews.length; i++) {
      rating += reviews[i].stars;
    }
    if(reviews.isNotEmpty){
      return rating / reviews.length;
    } else {
      return rating;
    }
  }

  static ReviewModel getUserReview(List<ReviewModel> reviews, String uid, String name) {
    ReviewModel userRating = ReviewModel(uid: uid, userName: name, stars: 0, review: "");
    for (int i = 0; i < reviews.length; i++) {
      if (reviews[i].uid == uid) {
        userRating = reviews[i];
      }
    }
    return userRating;
  }

  static List<ReviewModel> fromMap(Map<String, dynamic> map) {
    List<ReviewModel> list = [];
    for (int i = 0; i < map.length; i++) {
      list.add(ReviewModel.fromMap(map.values.elementAt(i)));
    }
    return list;
  }

  static StarsModel getStarsCount(List<ReviewModel> list) {
    int one = 0;
    int two = 0;
    int three = 0;
    int four = 0;
    int five = 0;
    for (int i = 0; i < list.length; i++) {
      final stars = list[i].stars;
      if (stars == 1) {
        one++;
      } else if (stars == 2) {
        two++;
      } else if (stars == 3) {
        three++;
      } else if (stars == 4) {
        four++;
      } else if (stars == 5) {
        five++;
      }
    }
    return StarsModel(
        oneStars: one,
        twoStars: two,
        threeStars: three,
        fourStars: four,
        fiveStars: five);
  }

  static List<ReviewModel> getTextReviews(List<ReviewModel> reviews){
    List<ReviewModel> textReviews = [];
    for(int i = 0; i < reviews.length; i++){
      final review = reviews[i].review;
      if(review.isNotEmpty){
        textReviews.add(reviews[i]);
      }
    }
    return textReviews;
  }
}

class ReviewModel {
  String uid;
  String userName;
  double stars;
  String review;

  ReviewModel({
    required this.uid,
    required this.userName,
    required this.stars,
    required this.review,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userName: map["name"],
      stars: map["stars"],
      review: map["review"],
      uid: map["uid"],
    );
  }
}
