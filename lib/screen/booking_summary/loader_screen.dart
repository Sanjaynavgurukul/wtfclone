import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wtf/helper/app_constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 1300), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HeroExamplePage()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xff922224),
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: new Text(
            'Your Order is successful',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Hero(
          tag: 'summaryAnimation',
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HeroExamplePage()));
            },
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset('assets/svg/success_bg.svg',
                      semanticsLabel: 'Acme Logo'),
                  Image.asset(
                    'assets/gif/payment_done.gif',
                    width: 260,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class HeroExamplePage extends StatefulWidget {
  @override
  State<HeroExamplePage> createState() => _HeroExamplePageState();
}

class _HeroExamplePageState extends State<HeroExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: new Text(
          'Your Order is successful',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: <Widget>[
              Hero(
                  tag: 'summaryAnimation',
                  child: Container(
                    height: 360,
                    color: Color(0xff922224),
                    padding: EdgeInsets.only(bottom: 100),
                    alignment: Alignment.center,
                    child: SafeArea(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/success_bg.svg',
                              semanticsLabel: 'Acme Logo'),
                          Image.asset(
                            'assets/gif/payment_done.gif',
                            width: 120,
                          ),
                        ],
                      ),
                    ),
                  )),
              Container(
                //color: Colors.white,
                padding: EdgeInsets.only(top: 310, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff292929)),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
                  child: Column(
                    children: [
                      amountLabel(label: 'Booked at', value: 'Mass Monster'),
                      SizedBox(height: 8),
                      amountLabel(label: 'Booked at', value: 'Mass Monster'),
                      SizedBox(height: 8),
                      amountLabel(label: 'Booked at', value: 'Mass Monster'),
                      SizedBox(height: 8),
                      amountLabel(label: 'Booked at', value: 'Mass Monster'),
                      SizedBox(height: 8),
                      amountLabel(label: 'Booked at', value: 'Mass Monster'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(bottom: 0,top: 20),
            child: Text.rich(
              TextSpan(
                children: <WidgetSpan>[
                  WidgetSpan(child: Icon(Icons.add)),
                  WidgetSpan(child: Text('Coins Earned - ',style:TextStyle(fontSize: 14,fontWeight:FontWeight.w400))),
                  WidgetSpan(child: Text('500',style:TextStyle(fontSize: 14,fontWeight:FontWeight.w400))),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(bottom: 12,top: 4),
            child: Text('Total Coins balance - 13500',style:TextStyle(fontSize: 14,fontWeight:FontWeight.w400)),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(left: 16, right: 16, top: 18),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: AppConstants.boxBorderColor),
                  child: Text("Redeem", style: TextStyle(fontSize: 16))),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(left: 16, right: 16, top: 18),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                          width: 1, color: AppConstants.boxBorderColor)),
                  child: Text("Back to home", style: TextStyle(fontSize: 16))),
            ),
          )
        ]),
      ),
    );
  }

  Widget amountLabel({String label, String value}) {
    return Row(
      children: [
        Text(label ?? '',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        Spacer(),
        Text('\u{20B9}${value ?? ''}')
      ],
    );
  }
}
