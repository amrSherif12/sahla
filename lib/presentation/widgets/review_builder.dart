import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewBuilder extends StatelessWidget {
  String name;
  double rating;
  String review;
  bool blueBack;
  ReviewBuilder({
    Key? key,
    required this.name,
    required this.rating,
    required this.review,
    required this.blueBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 21,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'F',
                color: Colors.white,
              ),
            ),
            const Spacer(),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: 22,
              ignoreGestures: true,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: blueBack == false ? Colors.blue : Colors.white,
              ),
              unratedColor:
                  blueBack == false ? Colors.blueGrey : Colors.black38,
              onRatingUpdate: (double value) {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          review,
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'F',
              color: blueBack == false ? Colors.grey[300] : Colors.grey[200]),
          overflow: TextOverflow.clip,
        ),
        blueBack == true
            ? const Divider(
                height: 50,
                thickness: 2,
              )
            : Divider(
                height: 50,
                thickness: 2,
                color: Colors.grey[800],
              ),
      ],
    );
  }
}
