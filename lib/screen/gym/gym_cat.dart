import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/screen/gym/gym_category_screen.dart';

class GymCat extends StatefulWidget {
  static const routeName = '/gymCat';
  const GymCat({Key key}) : super(key: key);

  @override
  _GymCatState createState() => _GymCatState();
}

class _GymCatState extends State<GymCat> {
  GymStore user;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: AppColors.BACK_GROUND_BG,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(height: 400.0, viewportFraction: 1),
                items: [1, 2, 3].map((i) {
                  ExploreCardColor color =
                  ExploreCardColor.getColorList()[i - 1];
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 12, left: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(
                              color: Color(0xff0D0D0D),
                              borderRadius:
                              BorderRadius.all(Radius.circular(12)),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.topRight,
                                colors: [
                                  color.leftColor ?? Colors.transparent,
                                  color.rightColor ?? Color(0xff164741),
                                ],
                              ),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                child: Image.asset(
                                    color.image ?? 'assets/images/pro.png',
                                    height: 100),
                                // child: SvgPicture.asset(
                                //     color.image??'assets/images/pro.png',
                                //     semanticsLabel: 'lite Gym'
                                // ),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.all(0),
                                title: Text(color.label ?? 'NO NAME',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal)),
                              ),
                              Container(
                                height: 36,
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xff292929).withOpacity(0.5),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff2e2e2e).withOpacity(0.75),
                                        Color(0xffc4c4c4).withOpacity(0.75),
                                      ],
                                    )),
                                child: Text('( Starting at 99 )'),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('Some Feature',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Some Feature Two',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Some Feature Three',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Some Feature Four',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 141,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                    color: Color(0xff292929),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5))),
                                child: Text('Know more',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.normal)),
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ));
                    },
                  );
                }).toList(),
              ),
              ListTile(
                  title: Text('Categories'),
                  subtitle: Text('Choose your gym of your budget',
                      style: TextStyle(fontWeight: FontWeight.w200))),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cat(label: 'WTF ELITE', image: 'assets/images/elite.png'),
                    cat(label: 'WTF LUXURY', image: 'assets/images/luxe.png'),
                    cat(label: 'WTF PRO', image: 'assets/images/pro.png'),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              ListTile(
                title: Text('Recommended'),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: getRecommended(),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getRecommended() => [
    recommendedItem(index: 0),
    recommendedItem(index: 1),
    recommendedItem(index: 2)
  ];

  Widget recommendedItem({int index = 0}) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg"),
                    fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(8))),
                    child: Image.asset(
                      ExploreCardColor.getColorList()[index].image,
                      height: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('WTF Crossfit Advance', style: TextStyle(fontSize: 14)),
            subtitle: Text(
              'Noida Sector 8,C Block',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget cat({@required String image, @required String label}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            width: 94,
            height: 94,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Image.asset(image ?? 'assets/images/pro.png'),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            label ?? 'Non Label',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
          )
        ],
      ),
    );
  }

}
