import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/explore_controller_presenter.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/common_function.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/gym_search_model.dart';
import 'package:wtf/model/gym_slot_model.dart';
import 'package:wtf/screen/DiscoverScreen.dart';
import 'package:wtf/widget/progress_loader.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    implements ExploreContract {
  TextEditingController _searchController = TextEditingController();
  ExplorePresenter _presenter;
  GymSearchModel _searchResultModel;
  bool isLoaded = true;
  GymStore store;

  @override
  void initState() {
    super.initState();
    _presenter = new ExplorePresenter(this);
    // getGyms();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // appBar
                SizedBox(
                  height: 10,
                ),
                // Search Column
                Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Your Location",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(padding: EdgeInsets.all(8.0)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: store.currentAddress != null
                          ? TextFormField(
                              autofocus: true,
                              controller: _searchController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.search,
                              cursorColor: Colors.white,
                              onChanged: (val) async {
                                // FocusScope.of(context).unfocus();
                                if (val.length > 3) {
                                  await searchGyms(val);
                                }
                              },
                              onFieldSubmitted: (val) async {
                                FocusScope.of(context).unfocus();
                                if (val.length > 3) {
                                  await searchGyms(val);
                                } else {
                                  FlashHelper.informationBar(context,
                                      message:
                                          'Please enter at least 3 character to perform search');
                                }
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 0.0, bottom: 0.0, left: 17),
                                hintText:
                                    '${store.currentAddressResult.formattedAddress}',
                                hintStyle: TextStyle(
                                    color: Colors.white70, fontSize: 15),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    await searchGyms(_searchController.text);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(7),
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
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
                            )
                          : Loading(),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 24,
                    //             width: 24,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.black,
                    //                 shape: BoxShape.circle),
                    //             child: Icon(
                    //               Icons.location_on_outlined,
                    //               color: Colors.white,
                    //               size: 18,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 7,
                    //           ),
                    //           Text('Near By',
                    //               style: TextStyle(
                    //                   color: Colors.white, fontSize: 14)),
                    //         ],
                    //       ),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 24,
                    //             width: 24,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.black,
                    //                 shape: BoxShape.circle),
                    //             child: Icon(
                    //               Icons.location_on_outlined,
                    //               color: Colors.white,
                    //               size: 18,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 7,
                    //           ),
                    //           Text('Sec 50',
                    //               style: TextStyle(
                    //                   color: Colors.white, fontSize: 14)),
                    //         ],
                    //       ),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 24,
                    //             width: 24,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.black,
                    //                 shape: BoxShape.circle),
                    //             child: Icon(
                    //               Icons.location_on_outlined,
                    //               color: Colors.white,
                    //               size: 18,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 7,
                    //           ),
                    //           Text('Sec 76',
                    //               style: TextStyle(
                    //                   color: Colors.white, fontSize: 14)),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
// Search Column
                SizedBox(
                  height: 25.0,
                ),
                _searchResultModel != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${_searchResultModel.data.length} results show in your area',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : SizedBox.shrink(),
                // : Container(
                //     alignment: Alignment.center,
                //     child: Text(
                //       'Search Gym',
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 15,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   ),

                SizedBox(
                  height: 12.0,
                ),
                Expanded(
                  child: !isLoaded
                      ? LoadingWithBackground()
                      : _searchResultModel == null
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                'No Record Found',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _searchResultModel.data.length,
                              itemBuilder: (context, index) {
                                var item = _searchResultModel.data[index];
                                return GymCard(item: item);
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onGetGymDetailsSuccess(GymDetailsModel model) {
    // TODO: implement onGetGymDetailsSuccess
  }

  @override
  void onGetGymError(Object errorTxt) {
    setState(() {
      // _searchResultModel = model;
      isLoaded = true;
    });
    if (errorTxt is String) {
      CommonFunction.showToast(errorTxt);
    } else if (errorTxt is GymModel) {
      CommonFunction.showToast(errorTxt.message);
    }
    CommonFunction.showToast(errorTxt);
  }

  @override
  void onGetGymSuccess(GymModel model) {}

  @override
  void onsearchGymSuccess(GymSearchModel model) {
    if (model != null && model.status) {
      setState(() {
        _searchResultModel = model;
        isLoaded = true;
      });
    } else {
      CommonFunction.showToast(model.message);
    }
  }

  Future<void> searchGyms(String name) async {
    // CommonFunction.showProgressDialog(context);
    print("search Gym 0");
    isLoaded = false;
    setState(() {
      _searchResultModel = null;
    });
    await _presenter.searchGym(name);
  }

  @override
  void onGymPlansSuccess(GymPlanModel model) {
    // TODO: implement onGymPlansSuccess
  }

  @override
  void onGymSlotSuccess(GymSlotModel model) {
    // TODO: implement onGymSlotSuccess
  }

  @override
  void onAddSubscriptionSuccess(CommonModel model) {
    // TODO: implement onAddSubscriptionSuccess
  }
}
