import 'package:flutter/material.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/DiscoverScreen.dart';

class GymListSearchAdapter extends SearchDelegate<GymModelData> {
  final List<GymModelData> searchableList;
  final Function(GymModelData data) onClick;

  GymListSearchAdapter({@required this.searchableList,@required this.onClick});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          //close(context, null);
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<GymModelData> suggestionList = query.isEmpty
        ? searchableList
        : searchableList
        .where((p) => p.gymName
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
        itemBuilder: (context, index) {
          final GymModelData gym = suggestionList[index];
          return InkWell(
              onTap: () {
                print('on tap search called ----');
                Navigator.pop(context);
                onClick(gym);
              },
              child: Container(
                child: GymCard(recommended_list: false,item: gym,clicable: false,),
              ));
        });
  }
}