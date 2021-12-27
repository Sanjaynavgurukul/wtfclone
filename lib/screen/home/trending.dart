import 'package:flutter/material.dart';
// import 'package:wtf/utils/utils.dart';

class Trending extends StatelessWidget {
  const Trending({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          _trendingItem(),
          _trendingItem(),
        ],
      ),
    );
  }

  _trendingItem () => Stack(
    children: [
      Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: const [
              Colors.transparent,
            Colors.red,
            ],
            stops: const [0.03, 1.0],
          ),
        ),
      ),
      Positioned(
        child: Text('WTF World\'s Gym', style: TextStyle(color: Colors.white),),
        bottom: 45,
        left: 20,
      ),
      Positioned(
        child: Text('aaa', style: TextStyle(color: Colors.white, fontSize: 10),),
        bottom: 25,
        left: 20,
      ),
      Positioned(
        child: Text('4:35pm', style: TextStyle(color: Colors.white, fontSize: 10),),
        bottom: 10,
        left: 20,
      ),
      Positioned(
        child: Text('2323', style: TextStyle(color: Colors.white, fontSize: 10),),
        bottom: 35,
        right: 20,
      ),
      Positioned(
        child: Text('sdfsdf', style: TextStyle(color: Colors.white, fontSize: 10),),
        bottom: 20,
        right: 20,
      ),
    ],
  );
}
