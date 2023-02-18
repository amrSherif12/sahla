import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:king_app/data/helpers/firestore_helper.dart';
import 'package:king_app/data/models/review_model.dart';
import '../../../constants/color.dart';

class ReviewPage extends StatefulWidget {
  String type;
  String service;
  String id;
  String name;
  ReviewModel review;
  ReviewPage({
    Key? key,
    required this.name,
    required this.id,
    required this.service,
    required this.type,
    required this.review,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = widget.review.review;
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'F',
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        FireStoreHelper.instance.addReview(
                          widget.type,
                          widget.service.toLowerCase(),
                          widget.id,
                          controller.text,
                          widget.review.stars,
                          context,
                        );
                      },
                      child: const Text(
                        "POST",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'F',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const Center(
                        child: Text(
                          "Ratting",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'F'),
                        ),
                      ),
                      Center(
                        child: RatingBar.builder(
                          initialRating: widget.review.stars,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          unratedColor: Colors.black26,
                          onRatingUpdate: (double value) {
                            widget.review.stars = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: controller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(width: 1, color: ColorConst.base)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(width: 1, color: ColorConst.base)),
                          label:
                              const Text("Describe your experience (optional)"),
                          labelStyle: TextStyle(
                              color: ColorConst.base, fontFamily: 'F'),
                        ),
                        style: const TextStyle(
                            fontFamily: 'F', color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
