import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';

class RateSession extends StatelessWidget {
  const RateSession({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return Column(
      children: [
        // SizedBox(
        //   child: ListView.builder(
        //     itemCount: 2,
        //     scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     itemBuilder: ((context, index) {
        //       return Container(
        //         width: MediaQuery.of(context).size.width,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Stack(
        //               children: [
        //                 Container(
        //                   height: 64,
        //                   alignment: Alignment.center,
        //                   width: double.infinity,
        //                   margin:
        //                   EdgeInsets.only(left: 30, right: 30, top: 30),
        //                   decoration: BoxDecoration(
        //                     gradient: LinearGradient(
        //                         begin: Alignment.centerLeft,
        //                         end: Alignment.centerRight,
        //                         colors: [
        //                           index % 2 == 0
        //                               ? Colors.redAccent[400]
        //                               : Color(0xff52C234),
        //                           Color(0xff061700),
        //                         ]),
        //                     borderRadius: BorderRadius.only(
        //                       topLeft: Radius.circular(80),
        //                       bottomLeft: Radius.circular(80),
        //                       bottomRight: Radius.circular(80),
        //                     ),
        //                   ),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         'Workout Completed',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontSize: 16,
        //                           fontWeight: FontWeight.w700,
        //                         ),
        //                       ),
        //                       Text(
        //                         'Chest ,Triceps ,Cardio',
        //                         style: GoogleFonts.openSans(
        //                           color: Colors.white,
        //                           fontSize: 14,
        //                           fontWeight: FontWeight.w400,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: Container(
        //                     height: 57,
        //                     width: 57,
        //                     decoration: BoxDecoration(
        //                       color: Colors.black,
        //                       borderRadius: BorderRadius.circular(90),
        //                     ),
        //                     margin: EdgeInsets.only(right: 24),
        //                     padding: EdgeInsets.all(3),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         gradient: LinearGradient(
        //                             begin: Alignment.centerLeft,
        //                             end: Alignment.centerRight,
        //                             colors: [
        //                               index % 2 == 0
        //                                   ? Colors.redAccent[400]
        //                                   : Color(0xff52C234),
        //                               Color(0xff061700),
        //                             ]),
        //                         borderRadius: BorderRadius.circular(90),
        //                       ),
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             SizedBox(height: 20),
        //             Text(
        //               'Rate your Session',
        //               style: GoogleFonts.openSans(
        //                 color: Colors.white,
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w600,
        //               ),
        //             ),
        //             Container(
        //               height: 20,
        //               color: Colors.white,
        //               width: 200,
        //               margin: EdgeInsets.only(top: 10),
        //             ),
        //           ],
        //         ),
        //       );
        //     }),
        //   ),
        // ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 64,
                          alignment: Alignment.center,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  2 % 2 == 0
                                      ? Colors.redAccent[400]
                                      : Color(0xff52C234),
                                  Color(0xff061700),
                                ]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Workout Completed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${Helper.formatDate2(DateTime.now().toIso8601String())}',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            margin: EdgeInsets.only(right: 24),
                            padding: EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      2 % 2 == 0
                                          ? Colors.redAccent[400]
                                          : Color(0xff52C234),
                                      Color(0xff061700),
                                    ]),
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rate your Session',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RatingBar.builder(
                      unratedColor: Colors.grey.withOpacity(0.5),
                      initialRating: 0,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        store.setSessionRating(rating: rating);
                        print(rating);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 64,
                          alignment: Alignment.center,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  2 % 2 == 0
                                      ? Colors.redAccent[400]
                                      : Color(0xff52C234),
                                  Color(0xff061700),
                                ]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rate Your Trainer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${store.currentTrainer.data.name ?? ''}',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            margin: EdgeInsets.only(right: 24),
                            padding: EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      2 % 2 == 0
                                          ? Colors.redAccent[400]
                                          : Color(0xff52C234),
                                      Color(0xff061700),
                                    ]),
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rate your Trainer',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RatingBar.builder(
                      unratedColor: Colors.grey.withOpacity(0.5),
                      initialRating: 0,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        store.setTrainerRating(rating: rating);
                        print(rating);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 79,
          margin: EdgeInsets.symmetric(horizontal: 37, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xffffffff)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Comment',
                hintStyle: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (String value){
                store.setComment(comment: value);
              },
            ),
          ),
        ),
      ],
    );
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: ListView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 64,
                          alignment: Alignment.center,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  index % 2 == 0
                                      ? Colors.redAccent[400]
                                      : Color(0xff52C234),
                                  Color(0xff061700),
                                ]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Workout Completed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Chest ,Triceps ,Cardio',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            margin: EdgeInsets.only(right: 24),
                            padding: EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      index % 2 == 0
                                          ? Colors.redAccent[400]
                                          : Color(0xff52C234),
                                      Color(0xff061700),
                                    ]),
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rate your Session',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 20,
                      color: Colors.white,
                      width: 200,
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
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
