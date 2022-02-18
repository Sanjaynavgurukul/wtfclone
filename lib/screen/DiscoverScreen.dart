import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/gym/membership_page.dart';
import 'package:wtf/widget/ComingSoonWidget.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/progress_loader.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        title: Text(
          ' Discover WTF ${store.discoverType == 'gym' ? 'Arena' : 'Fitness Studios'}',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                SearchBar(),
                SizedBox(
                  height: 25.0,
                ),
                Expanded(
                  child: store.selectedGymTypes == null
                      ? LoadingWithBackground()
                      : store.selectedGymTypes != null &&
                              store.selectedGymTypes.data.isNotEmpty
                          ? ListView.builder(
                              itemCount: store.selectedGymTypes.data.length,
                              itemBuilder: (context, index) {
                                var item = store.selectedGymTypes.data[index];
                                return GymCard(item: item);
                              },
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text(
                                'No Record Found',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                ),
                UIHelper.verticalSpace(20.0),
                ComingSoonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.setGymTypes(data: null);
    super.dispose();
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(builder: (context, store, child) {
      return Row(
        children: [
          Expanded(
            flex: 8,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                // enabled: false,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  store.determinePosition();
                  NavigationService.navigateTo(Routes.searchScreen);
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: 0.0, bottom: 0.0, left: 17),
                  hintText: 'Explore WTF fitness centers near you',
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.0,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      // store.determinePosition();
                      // NavigationService.navigateTo(
                      //     Routes.searchScreen);
                    },
                    child: Container(
                      margin: EdgeInsets.all(7),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: AppConstants.primaryColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
          ),
          UIHelper.horizontalSpace(12.0),
          Flexible(
            child: InkWell(
              onTap: () async {
                LocationResult result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlacePicker(
                      Helper.googleMapKey,
                      displayLocation: store.selectedNewLocation != null
                          ? LatLng(store.selectedNewLocation.latLng.latitude,
                              store.selectedNewLocation.latLng.longitude)
                          : LatLng(store.currentPosition.latitude,
                              store.currentPosition.longitude),
                    ),
                  ),
                );
                print(result);
                setState(() {
                  if (result != null) {
                    store.setNewLocation(
                      result: result,
                      context: context,
                    );
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class GymCard extends StatelessWidget {
  const GymCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final GymData item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('gym details: ${item.toJson()}');
        context.read<GymStore>().getGymDetails(
              context: context,
              gymId: item.userId,
            );
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => BuyMemberShipPage(
              gymId: item.userId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 37),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white70,
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.only(right: 15),
              child: Stack(
                children: [
                  GradientImageWidget(
                    network: item.coverImage,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  item.type?.capitalize() ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  item.gymName ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '9 am-11 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  if (item.rating != 0)
                    Positioned(
                      top: 12.0,
                      right: 12.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: item.rating <= 2
                              ? Colors.red
                              : item.rating > 2 && item.rating <= 3
                                  ? Colors.orange
                                  : Colors.green,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.rating.toString() + ' ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 14.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  // if (item.status != 'active')
                  //   Positioned(
                  //     top: 12.0,
                  //     left: 12.0,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 4.0,
                  //         horizontal: 6.0,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: item.rating <= 2
                  //             ? Colors.red
                  //             : item.rating > 2 && item.rating <= 3
                  //                 ? Colors.orange
                  //                 : Colors.green,
                  //         borderRadius: BorderRadius.circular(6.0),
                  //       ),
                  //       child: Text(
                  //         'Coming Soon',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 14.0,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          '${item.address1}, ${item.address2}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
