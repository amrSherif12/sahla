import 'package:flutter/material.dart';
import 'package:king_app/presentation/widgets/review_builder.dart';
import '../../../constants/color.dart';
import '../../../data/models/review_model.dart';

class SeeAllReviews extends StatelessWidget {
  List<ReviewModel> reviews;
  SeeAllReviews({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConst.secColor,
              ColorConst.mainColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const Text(
                    "Reviews",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'F', fontSize: 30),
                  ),
                  Icon(
                    Icons.arrow_back_rounded,
                    color: ColorConst.secColor,
                    size: 40,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: ReviewBuilder(
                          name: review.userName,
                          rating: review.stars,
                          review: review.review,
                        blueBack: true,
                      ),
                    );
                  },
                  itemCount: reviews.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
