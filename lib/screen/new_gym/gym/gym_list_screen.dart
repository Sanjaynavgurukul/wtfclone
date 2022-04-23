import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/new_gym/gym/bloc/gym_list_bloc.dart';
import 'package:wtf/widget/progress_loader.dart';

class GymListScreen extends StatefulWidget {
  const GymListScreen({Key key}) : super(key: key);

  @override
  _GymListScreenState createState() => _GymListScreenState();
}

class _GymListScreenState extends State<GymListScreen> {
  //local Variables :D
  GymListBloc _bloc = GymListBloc();
  GymModel _data = GymModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _bloc..add(FetchGymListEvent()),
        child: BlocConsumer(
            bloc: _bloc,
            listener: (context, state) {
              // do stuff here based on BlocA's state
            },
            builder: (context, state) {
              if(state is GymListInitial){
                return Center(child: Loading(),);
              }else if(state is GymListFetchedState){
                _data = state.gymModel;
                return Container();
              }else{
                return Center(child: Text('Something Went Wrong'),);
              }
            }));
  }
}
