import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/Helper.dart';

class Slide2 extends StatefulWidget {
  @override
  State<Slide2> createState() => _Slide2State();
}

class _Slide2State extends State<Slide2> {
  final _place = TextEditingController();
  GymStore store;
  UserController userController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchLocation() async {
    await context.read<GymStore>().determinePosition(context);
    //TODO Location CHECK
    _place.text = '${context.read<GymStore>().getAddress()}';
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
    _place.text = result.formattedAddress;
    store.preambleModel.location = _place.text;
    store.preambleModel.lat = result.latLng.latitude.toString();
    store.preambleModel.long = result.latLng.longitude.toString();
    setState(() {
    });
    // Handle the result in your way
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    fetchLocation();
    return Consumer<GymStore>(
      builder: (context, user, snapshot) {
        if(user.preambleModel.location != null || user.preambleModel.location.isNotEmpty){
          _place.text = user.preambleModel.location;
        }
        return Scaffold(
          body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(top: 40, left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Where do you live',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SvgPicture.asset('assets/svg/Location.svg',
                      semanticsLabel: 'Location Image',width: 200,),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
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
                      controller: _place,
                      onChanged: (val) {
                        user.preambleModel.location = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
