import 'package:flutter/material.dart';
import 'package:wtf/screen/schedule/arguments/ex_play_details_argument.dart';

class ExStartScreen extends StatefulWidget {
  static const routeName = '/exStartScreen';
  const ExStartScreen({Key key}) : super(key: key);

  @override
  _ExStartScreenState createState() => _ExStartScreenState();
}

class _ExStartScreenState extends State<ExStartScreen> {

  @override
  Widget build(BuildContext context) {
    final ExPlayDetailsArgument args =
    ModalRoute.of(context).settings.arguments as ExPlayDetailsArgument;

    if(args == null || args.data== null){
      return Center(child: Text('Something went wrong pleas try again later!'),);
    }
    return Container();
  }
}
