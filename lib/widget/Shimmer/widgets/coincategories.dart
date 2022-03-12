import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/model/offers.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/progress_loader.dart';

class CoinCategoriesIcon extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  const CoinCategoriesIcon({
    Key key,
    this.categoryName,
    this.categoryImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = .12.sh;
    double width = .8.sw;
    GymStore store = Provider.of<GymStore>(context);
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(color: AppConstants.stcoinbgColor),
          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          color: AppColors.BACK_GROUND_BG,
          // gradient: LinearGradient(
          //   begin: FractionalOffset.topCenter,
          //   end: FractionalOffset.bottomCenter,
          //   colors: [Colors.transparent, Colors.white12, Colors.transparent],
          //   stops: [0.0, 0.5, 1.0],
          // )
      ),
      child: ListView(
        controller: ScrollController(keepScrollOffset: false),
        children: [
          IconButton(
            onPressed: () async {
              store.offers = Offers();
              store.offerCategory = "";
              store.getOffers(context: context, keywords: categoryName);
              NavigationService.navigateTo(Routes.shoppingScreen);
            },
            icon: Image.network(
              categoryImage,
              fit: BoxFit.cover,
              height: height,
              width: width,
              loadingBuilder: (context, _, chunk) => chunk == null
                  ? _
                  : RectangleShimmering(
                      width: double.infinity,
                      height: 180.0,
                    ),
            ),
            iconSize: 100.sp,
          ),
          Center(
            child: Text(
              categoryName,
              style: TextStyle(
                fontSize: 14.sp,
                letterSpacing: .6,
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
