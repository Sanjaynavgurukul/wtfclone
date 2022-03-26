// ignore_for_file: prefer__ructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/ui_helpers.dart';

import '../../main.dart';

class Slide0 extends StatefulWidget {
  final String title;
  final String subTitle;
  @override
  State<Slide0> createState() => _Slide0State();

  Slide0({this.title, this.subTitle});
}

class _Slide0State extends State<Slide0> {
  final _user = TextEditingController();
  String addressVal = '';
  @override
  void initState() {
    super.initState();
    // final user = Provider.of<UserController>(context, listen: false);
    // if (user.name != null) {
    //   _user.text = user.name;
    // }
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() async {
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null ||
    //     now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   CommonFunction.showToast("Press again to exit");
    //   // Fluttertoast.showToast(msg: exit_warning);
    //   return Future.value(false);
    // }
    return Future.value(false);
  }

  Future<void> fetchLocation(GymStore store) async {
    await store.determinePosition(context).then((value){
      print('status of network -- $value');
      if(!value){
        showPlacePicker(store);
      }else{
        print('location else condition called dd --- ');
        if(addressVal.isNotEmpty){
          print('location else condition called --- is not empty ');
          showPlacePicker(store);
        }else{
          addressVal = '${context.read<GymStore>().getAddress()}';
          print('location else condition called --- $addressVal');
        setState(() {
        });
        }
      }
    });
    //TODO Location CHECK
  }

  void showPlacePicker(GymStore store) async {
    // double lat = store.lat != null && store.currentPosition.latitude != null ? store.currentPosition.latitude:28.596669322602807;
    // double lng = store.currentPosition != null &&store.currentPosition.longitude != null ? store.currentPosition.longitude:77.32866249084584;
    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          Helper.googleMapKey,
          displayLocation: LatLng(
              store.getLat(), store.getLng()),
        ),
      ),
    );
    print('check result ${result.formattedAddress}');
    print('check result ${result.latLng.longitude}');
    print('check result ${result.latLng.latitude}');
    addressVal = result.formattedAddress;
    store.preambleModel.location = addressVal;
    store.preambleModel.lat = result.latLng.latitude.toString();
    store.preambleModel.long = result.latLng.longitude.toString();
    setState(() {
    });
    // Handle the result in your way
  }

  @override
  Widget build(BuildContext context) {
    print('cehck result $addressVal');
    return Consumer<GymStore>(
      builder: (context, user, snapshot) {
        if(user.preambleModel.location != null && user.preambleModel.location.isNotEmpty){
          addressVal = user.preambleModel.location;
        }else{
          user.preambleModel.location = addressVal;
        }
        return Container(
          padding: EdgeInsets.only(top: 40,left: 18,right: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hey ${locator<AppPrefs>().userName.getValue().capitalize()}!',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
                UIHelper.verticalSpace(10.0),
                Text(
                  widget.title.capitalize(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                UIHelper.verticalSpace(12.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    widget.subTitle,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w100
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                SvgPicture.asset('assets/svg/Location.svg',
                  semanticsLabel: 'Location Image',width: 200,),
                SizedBox(
                  height: 40,
                ),
                // Container(
                //   child: Row(children: [
                //     Expanded(child: TextFormField(
                //       enabled: false,
                //     initialValue: locationValue??'',
                //     onChanged: (val) {
                //       locationValue = val;
                //       user.preambleModel.location = locationValue ;
                //       setState(() {});
                //     },
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.only(
                //           top: 0.0,
                //           bottom: 0.0,
                //           left: 17,
                //         ),
                //         hintText: 'Enter Your Location',
                //         hintStyle: TextStyle(
                //           color: Colors.white70,
                //           fontSize: 13.0,
                //         ),
                //         filled: true,
                //         fillColor: Color(0xff2d2d2d),
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide.none,
                //           borderRadius: BorderRadius.circular(4.0),
                //         ),
                //       ),
                //     ),),
                //     InkWell(
                //       onTap: () {
                //         showPlacePicker(user);
                //       },
                //       child: Container(
                //         margin: EdgeInsets.all(5.0),
                //         height: 25,
                //         width: 25,
                //         decoration: BoxDecoration(
                //             gradient: LinearGradient(
                //               begin: Alignment.topLeft,
                //               end: Alignment.bottomRight,
                //               colors: [
                //                 Color(0xffBA1406),
                //                 Color(0xff490000),
                //               ],
                //             ),
                //             borderRadius: BorderRadius.circular(4.0)),
                //         child: Center(
                //           child: Icon(
                //             Icons.location_on,
                //             color: Colors.white,
                //             size: 16.0,
                //           ),
                //         ),
                //       ),
                //     )
                //   ],),
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: (){
                      // showPlacePicker(user);
                      fetchLocation(user);
                    },
                    child: TextFormField(
                      controller: TextEditingController(text: addressVal ),
                      enabled: false,
                      style: TextStyle(fontWeight:FontWeight.w300),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                          left: 17,
                        ),
                        hintText: 'Enter Your Location',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            showPlacePicker(user);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xffBA1406),
                                    Color(0xff490000),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Center(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xff2d2d2d),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onChanged: (val) {
                        // addressVal = val;
                        // user.preambleModel.location = addressVal ;
                        // setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                // Padding(
                //   padding: EdgeInsets.all(2.0),
                //   child: AnimatedContainer(
                //     curve: Curves.easeIn,
                //     duration: Duration(
                //       milliseconds: 1000,
                //     ),
                //     transform: Matrix4.translationValues(0, 0, 1),
                //     width: MediaQuery.of(context).size.width * 0.85,
                //     child: TextField(
                //       onChanged: (val) {
                //         user.setValue(name: val);
                //       },
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //       controller: _user,
                //       cursorColor: AppColors.TEXT_DARK,
                //       decoration: InputDecoration(
                //         helperText: "Enter Name",
                //         helperStyle: TextStyle(
                //           color: Colors.white,
                //         ),
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                //         ),
                //         focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xffffffff)),
                //         ),
                //         border: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xffffffff)),
                //         ),
                //         suffixIcon: IconButton(
                //           onPressed: () => _user.clear(),
                //           icon: Icon(
                //             Icons.clear,
                //             color: Color(0xffffffff),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}