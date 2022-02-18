import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';

class RateSession extends StatelessWidget {
  const RateSession({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return Column(
      children: [
        Text(
          'Rate your session',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        RatingBar.builder(
          unratedColor: Colors.white,
          initialRating: 0,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            store.setSessionRating(rating: rating);
            print(rating);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Rate your Trainer',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        RatingBar.builder(
          unratedColor: Colors.white,
          initialRating: 0,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            store.setTrainerRating(rating: rating);
            print(rating);
          },
        )
      ],
    );
  }
}
