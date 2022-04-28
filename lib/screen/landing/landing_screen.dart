import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/screen/landing/home/home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  //Navigation Bar Page Index count
  //Setting Initial Page Index
  int pageIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  //Screens
  List<Widget> landingScreens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  //Method responsible for change page according navigation button action :D
  void onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity,70),
          child: ListTile(
            title: Text(
              'Hi Shloka',
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 13, color: Colors.white),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 3,
                ),
                new Image.asset(
                  'assets/logo/wtf_light.png',
                  height: 14,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            trailing:  CircleAvatar(
              radius: 30,
              backgroundColor: AppConstants.bgColor,
              child: Padding(
                padding: const EdgeInsets.all(2), // Border radius
                child: ClipOval(child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjNcQVGPiW5P018_LdtFjmXFN9aYRRnwqqQ&usqp=CAU')),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.widgets), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'My WTF'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Coins'),
          ],
          currentIndex: pageIndex,
          fixedColor: Colors.white,
          backgroundColor: AppColors.BACK_GROUND_BG,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedIconTheme:
              IconThemeData(color: AppConstants.white.withOpacity(0.3)),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.green),
          selectedIconTheme: IconThemeData(color: AppConstants.bgColor),
          enableFeedback: true,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
        body: IndexedStack(
          index: pageIndex,
          children: landingScreens,
        ),
      ),
    );
  }
}
