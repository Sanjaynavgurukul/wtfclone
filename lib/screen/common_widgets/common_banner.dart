import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/model/banner_model.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';

class CommonBanner extends StatelessWidget {
  const CommonBanner({this.bannerType,this.height=200,this.width = 200,this.fraction=0.8,this.second_banner_pref});

  final String bannerType;
  final String second_banner_pref;
  final double height;
  final double width;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, value, child) {
        return value.bannerList == null
            ? Container(
          height: height,
          width: width,
          child: Center(
            child: loadingState(),
          ),
        )
            : value.bannerList.isEmpty
            ? emptyList()
            : listCarouse(value.bannerList);
      },
    );
  }

  //Filter Data
  List<BannerItem> getFilterData({List<BannerItem> data, String bType,String secondBannerPref}) =>
      data.where((element) => element.type == bType || element.type == second_banner_pref).toList();

  //This is Carouse slider
  Widget listCarouse(List<BannerItem> list) {
    return CarouselSlider(
        options: CarouselOptions(
          height: height,

          viewportFraction: fraction,
          enlargeCenterPage: false,
          autoPlay: true,
          pageSnapping: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
        ),
        items: getFilterData(data: list, bType: bannerType)
            .map(
              (i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(fraction == 1 ? 0:12.0),
              child: Builder(
                builder: (BuildContext context) {
                  if (i.image == null) {
                    return Center(
                      child: Text("No image data"),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(left: 4 ,right: 4),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.all(Radius.circular(fraction == 1 ? 0:20))
                    ),
                    child: Image.network(
                      i.image,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, _, chunk) =>
                      chunk == null
                          ? _
                          : RectangleShimmering(
                        width: double.infinity,
                        height: 180.0,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ).toList()
    );
  }

  //Loading widget while data fetching
  Widget loadingState() {
    return CircularProgressIndicator(
      color: Colors.red,
    );
  }

  //Widget Empty Carouse
  Widget emptyList() {
    return Container();
  }
}
