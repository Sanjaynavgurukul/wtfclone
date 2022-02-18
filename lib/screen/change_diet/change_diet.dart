import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf/screen/change_diet/flexible_appbar.dart';
import 'package:wtf/screen/change_diet/widget/custom_radio.dart';

class ChangeDiet extends StatefulWidget {
  const ChangeDiet({Key key}) : super(key: key);

  @override
  _ChangeDietState createState() => _ChangeDietState();
}

class _ChangeDietState extends State<ChangeDiet> with TickerProviderStateMixin {
  bool show = false;
  bool scrollOrNot = true;
  final bool isPreview = false;
  int selectedIndex = 0;

  void showOrHide() {
    if (_scrollController.position.pixels >= 141) {
      setState(() {
        show = true;
      });
    } else {
      setState(() {
        show = false;
      });
    }

    if ((_scrollController.position.pixels ==
                _scrollController.position.minScrollExtent ||
            _scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) &&
        isPreview == true) {
      setState(() {
        scrollOrNot = false;
      });
    }
  }

  final _scrollController = ScrollController();

  List<Cat> getList() => [
        Cat(label: 'Veg', color: Colors.green, selected: true,fullLabel: 'Vegetarian'),
        Cat(label: 'Egg', color: Colors.orange, selected: false,fullLabel: 'Eggetarian'),
        Cat(label: 'Nonveg', color: Colors.red, selected: false,fullLabel: 'Non-Vegetarian')
      ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      showOrHide();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: isPreview == true ? const NeverScrollableScrollPhysics() : null,
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: false,
          // backgroundColor: Constants.darkOrange,
          // leading: InkWell(
          //   onTap: () => Navigator.pop(context),
          //   child: Container(
          //     margin: const EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //           width: 1, color: Colors.white.withOpacity(0.3)),
          //       shape: BoxShape.circle,
          //       // color: glassyColor.withOpacity(0.3)
          //     ),
          //     child:
          //     Icon(Icons.close, color: Colors.white.withOpacity(0.3)),
          //   ),
          // ),
          actions: [
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: getList().length,
                  itemBuilder: (context, index) {
                    Cat data = getList()[index];
                    data.selected = selectedIndex==index;
                    return CustomRadio(
                      data: data,
                      onClick: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  }),
            )
          ],
          pinned: false,
          expandedHeight: 350.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/wtf_light.png',
                        height: 20,
                      ),
                      SizedBox(width: 8),
                      Text('Powered')
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Nutrition From Kitchen',
                    style: GoogleFonts.montserrat(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Text(
                    getList()[selectedIndex].fullLabel,
                    style: GoogleFonts.lobster(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: getList()[selectedIndex].color),
                  )
                ],
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: FlexibleAppBar(
              image: '',
              color: null,
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Text(
              //         _model.name!,
              //         style: bigText.copyWith(
              //             color: Constants.darkOrange, fontWeight: FontWeight.w600),
              //       ),
              //       Container(
              //           decoration: BoxDecoration(
              //               color: glassyColor,
              //               borderRadius: BorderRadius.circular(100)),
              //           child: const Center(
              //               child: Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 10, horizontal: 20),
              //                 child: Text(
              //                   "Best Seller",
              //                   style:
              //                   TextStyle(color: Colors.green, fontSize: 12),
              //                 ),
              //               ))),
              //     ],
              //   ),
              // ),const Text(
              //   'Master at lose weight',
              //   style: TextStyle(fontSize: 14,color: Colors.black54),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10,top: 40),
              //   child: Text(
              //     'About Me',
              //     style: bigText.copyWith(
              //         fontSize: 16,
              //         color: Colors.black,
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              // Text(
              //   _model.description!,
              //   style: description.copyWith(fontSize: 16),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Text(
              //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nunc ut vel dui in aenean. Ornare tellus fringilla malesuada eu auctor. Massadiam libero egestas lectus.psum dolor sit amet, consectetur adipiscing elit. Sed nunc ut vel dui in aenean. Ornare tellus fringilla malesuada eu auctor. Massadiam libero egestas lectus.psum dolor sit amet, consectetur adipiscing elit. Sed nunc ut vel dui in aenean. Ornare tellus fringilla malesuada eu auctor. Massadiam libero egestas lectus. psum dolor sit amet, consectetur adipiscing elit. Sed nunc ut vel dui in aenean. Ornare tellus fringilla malesuada eu auctor. Massadiam libero egestas lectus.',
              //     style: description.copyWith(fontSize: 16),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10),
              //   child: Text(
              //     'Course Description',
              //     style: bigText.copyWith(
              //         fontSize: 16,
              //         color: Colors.black,
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              // Text(
              //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nunc ut vel dui in aenean. Ornare tellus fringilla malesuada eu auctor. Massadiam libero egestas lectus.',
              //   style: description.copyWith(fontSize: 16),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Container(
              //       height: 300,
              //       child: Image.asset("assets/courseImages.png")),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10),
              //   child: Text(
              //     'Prizing',
              //     style: bigText.copyWith(
              //         fontSize: 16,
              //         color: Colors.black,
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              // Text(
              //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nunc ut vel dui in aenean. Ornare tellus fringilla malesuada eu auctor. Massadiam libero egestas lectus.',
              //   style: description.copyWith(fontSize: 16),
              // ),
              // Container(
              //   height: 120,
              // ),
            ],
          ),
        )),
      ],
    );
  }
}

class Cat {
  String label;
  Color color;
  bool selected;
  String fullLabel;

  Cat({this.selected, this.color, this.label,this.fullLabel});
}
