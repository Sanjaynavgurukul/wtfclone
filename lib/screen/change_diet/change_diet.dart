import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/screen/change_diet/flexible_appbar.dart';
import 'package:wtf/screen/change_diet/widget/custom_radio.dart';
import 'package:wtf/screen/change_diet/widget/diet_item.dart';
import 'package:wtf/widget/progress_loader.dart';

class ChangeDiet extends StatefulWidget {
  const ChangeDiet({Key key}) : super(key: key);
  static const String routeName = '/changeDiet';

  @override
  _ChangeDietState createState() => _ChangeDietState();
}

class _ChangeDietState extends State<ChangeDiet> with TickerProviderStateMixin {
  bool show = false;
  bool scrollOrNot = true;
  final bool isPreview = false;
  int selectedIndex = 0;
  GymStore store;

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

  List<TopBarModel> getList() => [
    TopBarModel(
            label: 'Veg',
            color: Colors.green,
            selected: true,
            imageUrl: 'assets/images/veg_bg.png',
            fullLabel: 'Vegetarian'),
    TopBarModel(
            label: 'Egg',
            color: Colors.orange,
            selected: false,
        imageUrl: 'assets/images/egg_bg.png',
            fullLabel: 'Eggetarian'),
    TopBarModel(
            label: 'Nonveg',
            color: Colors.red,
            selected: false,
        imageUrl: 'assets/images/non_veg_bg.png',
            fullLabel: 'Non-Vegetarian')
      ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    store = context.watch<GymStore>();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      showOrHide();
    });

    super.initState();
  }

  void callData(){
    context.read<GymStore>().getAllDiet(context: context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: false,
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
                    TopBarModel data = getList()[index];
                    data.selected = selectedIndex == index;
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
          expandedHeight: 250.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
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
              image: getList()[selectedIndex].imageUrl,
              color: null,
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
          child: mainView(),
        )),
      ],
    ));
  }

  Widget coco() {
    return Scaffold(
      body: CustomScrollView(
        physics:
            isPreview == true ? const NeverScrollableScrollPhysics() : null,
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
                      TopBarModel data = getList()[index];
                      data.selected = selectedIndex == index;
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
            expandedHeight: 250.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
          SliverToBoxAdapter(child: mainView()),
        ],
      ),
    );
  }

  Widget mainView() {
    return Column(
      children: [
        ListTile(
          dense: true,
          tileColor: Colors.grey.withOpacity(0.5),
          title: Text('You are currently using free diet plans',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
          trailing: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Color(0XffC11818),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Upgrade'),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.verified_user,
                  size: 16,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        ListTile(
          dense: true,
          tileColor: AppConstants.bgColor,
          title: Text('View Current Diet Plans',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          trailing: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
        Container(
          child: Consumer<GymStore>(
            builder: (context, store, child) =>
            store.diet != null
                ? store.diet.isNotEmpty
                ? ListView.builder(
                itemCount: DietModel.getList().length,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 12,right: 12),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  DietModel data = DietModel.getList()[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title:Text(
                          data.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                          ),
                        ),dense: true,),

                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: data.list
                                .map((item) => DietItem(
                              data: item,
                            ))
                                .toList(),
                          ))
                    ],
                  );
                })
                : Center(
              child: Text(
                'No Challenges present as of now.',
                style: TextStyle(color: Colors.white),
              ),
            )
                : Loading(),
          )
        )
      ],
    );
  }
}

class TopBarModel {
  String label;
  Color color;
  bool selected;
  String fullLabel;
  String imageUrl;

  TopBarModel({this.selected, this.color, this.label, this.fullLabel,this.imageUrl});
}

class DietModel {
  String title;
  List<Diet> list;

  DietModel({this.title, this.list});

  static List<DietModel> getList() => [
        DietModel(title: 'Lean Body', list: [
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
        ]),
        DietModel(title: 'Lean Body', list: [
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
        ]),
        DietModel(title: 'Lean Body', list: [
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
          Diet(title: 'Fruity Reps', imageUrl: 'assets/images/veg_bg.png'),
        ]),

      ];
}

class Diet {
  String title;
  String imageUrl;

  Diet({this.title, this.imageUrl});
}
