import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';

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
    fetchLocation();
    final user = Provider.of<UserController>(context, listen: false);
    if (user.address != null) {
      _place.text = user.address;
    }
  }

  Future<void> fetchLocation() async {
    log('fetching');
    await context.read<GymStore>().determinePosition();
    var get = context.read<GymStore>().currentAddressResult;
    _place.text = '${get.formattedAddress}';
    context.read<UserController>().setValue(address: _place.text);
  }

  // void onError(PlacesAutocompleteResponse response) {
  //   log(response.errorMessage);
  // }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Consumer<UserController>(
      builder: (context, user, snapshot) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Select your locality ",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              Text(
                AppConstants.confidentialInfo,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: store.currentAddress != null
                      ? TextField(
                    controller: _place,
                    cursorColor: AppColors.TEXT_DARK,
                    onChanged: (val) {
                      user.setValue(address: val);
                    },
                    onTap: () async {
                      showPlacePicker(user);
                      // Prediction p = await PlacesAutocomplete.show(
                      //   context: context,
                      //   apiKey: Helper.googleMapKey,
                      //   mode: Mode.overlay, // Mode.fullscreen
                      //   onError: onError,
                      //   language: "en",
                      //   components: [
                      //     new Component(Component.country, "en")
                      //   ],
                      // );
                      // if (p != null) {
                      //   displayPrediction(p, user);
                      // }
                    },
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      helperText: "Search locality",
                      helperStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => _place.clear(),
                        icon: Icon(
                          Icons.clear,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  )
                      : Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      'Fetching location, Please wait...',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showPlacePicker(UserController user) async {
    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          Helper.googleMapKey,
          displayLocation: LatLng(
              store.currentPosition.latitude, store.currentPosition.longitude),
        ),
      ),
    );
    print(result);
    setState(() {
      _place.text = result.formattedAddress;
      user.setValue(address: result.formattedAddress);
    });
    // Handle the result in your way
  }

// Future<Null> displayPrediction(Prediction p, UserController user) async {
//   if (p != null) {
//     // get detail (lat/lng)
//     GoogleMapsPlaces _places = GoogleMapsPlaces(
//       apiKey: Helper.googleMapKey,
//       apiHeaders: await GoogleApiHeaders().getHeaders(),
//     );
//     PlacesDetailsResponse detail =
//         await _places.getDetailsByPlaceId(p.placeId);
//     setState(() {
//       _place.text = detail.result.formattedAddress;
//       user.setValue(address: _place.value.text);
//     });
//   }
// }
}