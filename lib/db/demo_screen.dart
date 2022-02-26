import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtf/db/bloc/demo_bloc.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key key}) : super(key: key);

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  DemoBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter BLoC"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (BuildContext context) =>DemoBloc()..add(FetchDataEvent()),
        child: BlocConsumer(
          bloc: _bloc,
          listener: (context, state) {
            if (state is FetchDataState) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Refreshed"),
                duration: Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            print("Widget has been built");
            if (state is DemoInitial) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Center(
                child: Text('Data Fetched'),
              );
            }
          },
        ),
      ),
    );
  }
}
