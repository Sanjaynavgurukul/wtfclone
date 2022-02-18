import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf/helper/colors.dart';

class BuySession extends StatelessWidget {
  const BuySession({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              // fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/workout1.png',
                    height: Get.height * 0.4,
                    fit: BoxFit.fill,
                    width: Get.width,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  child: Image.asset('assets/images/workout_background.png'),
                ),
                Positioned(
                  bottom: 70,
                  left: 20,
                  child: Text(
                    'Bronze Trainer Pack',
                    style: TextStyle(
                        color: Color(0xffb57b53),
                        fontSize: 28,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: Text(
                    'Achieving fitness goals require more than just a',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  left: 20,
                  child: Text(
                    'session! Be reqular and save with 1 on 1',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'Training Packs',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xff333333),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.white70,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'View Centers ( At Selected Centers Only )',
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Hava a promo code ?',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your code here',
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('APPLY'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Select a pack'.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.done,
                          size: 15,
                        ),
                        radius: 10,
                        backgroundColor: Colors.green,
                      ),
                      title: Text('1 Session',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      subtitle: Text('validity: 5 Days',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                      trailing: SizedBox(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              'Rs.1500',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Text(
                              'Rs.1500/season',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Buy your session'.toUpperCase(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
