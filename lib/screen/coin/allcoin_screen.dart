import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/widget/Shimmer/widgets/coincategories.dart';
import 'package:wtf/widget/progress_loader.dart';

class AllCoinScreen extends StatefulWidget {
  const AllCoinScreen({Key key}) : super(key: key);

  @override
  _AllCoinScreenState createState() => _AllCoinScreenState();
}

class _AllCoinScreenState extends State<AllCoinScreen> {
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Categories'),
          backgroundColor: AppColors.BACK_GROUND_BG,
        ),
        body: Padding(
          padding: EdgeInsets.all(12.r),
          child: store.shoppingCategories != null
              ? Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: .02.sw,
                      mainAxisSpacing: .015.sh,
                      crossAxisCount: 3,
                    ),
                    itemCount: store.shoppingCategories.data.length,
                    itemBuilder: (context, index) => CoinCategoriesIcon(
                      categoryName:
                          store.shoppingCategories.data[index].keyword,
                      categoryImage: store.shoppingCategories.data[index].icon,
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topCenter,
                  child: Loading(),
                ),
        ),
      ),
    );
  }
}
