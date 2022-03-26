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
  String locationValue = '';
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

  Future<void> fetchLocation() async {
    await context.read<GymStore>().determinePosition(context);
    //TODO Location CHECK

    locationValue = '${context.read<GymStore>().getAddress()}';
    setState(() {
    });
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
    print(result);
    locationValue = result.formattedAddress;
    store.preambleModel.location = locationValue;
    store.preambleModel.lat = result.latLng.latitude.toString();
    store.preambleModel.long = result.latLng.longitude.toString();
    setState(() {
    });
    // Handle the result in your way
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, user, snapshot) {
        if(user.preambleModel.location != null && user.preambleModel.location.isNotEmpty){
          locationValue = user.preambleModel.location;
        }
        return Container(
          padding: EdgeInsets.only(top: 40,left: 18,right: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hey ${locator<AppPrefs>().userName.getValue()}!',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                UIHelper.verticalSpace(10.0),
                Text(
                  widget.title,
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
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SvgPicture.asset('assets/svg/Location.svg',
                  semanticsLabel: 'Location Image',width: 200,),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Where do you live',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    onTap: (){
                      fetchLocation();
                    },
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
                    initialValue: locationValue??'',
                    onChanged: (val) {
                      locationValue = val;
                      user.preambleModel.location = locationValue ;
                      setState(() {});
                    },
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