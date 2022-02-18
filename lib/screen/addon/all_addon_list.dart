import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/main.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/widget/progress_loader.dart';

class AllLiveAddonList extends StatefulWidget {
  @override
  _AllLiveAddonListState createState() => _AllLiveAddonListState();
}

class _AllLiveAddonListState extends State<AllLiveAddonList> {
  GymStore store;
  @override
  Widget build(BuildContext context) {
    store = Provider.of<GymStore>(context);
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        title: Text(
          'WTF Powered Live Classes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppConstants.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          store.getAllLiveClasses(context: context);
        },
        color: AppConstants.white,
        child: Consumer<GymStore>(
          builder: (context, store, child) => store.allLiveClasses != null
              ? store.allLiveClasses.data != null &&
                      store.allLiveClasses.data.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: store.allLiveClasses.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Center(
                        child: LiveCard(
                          data: store.allLiveClasses.data[index],
                          isFullView: true,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'No live Classes found',
                      ),
                    )
              : Loading(),
        ),
      ),
    );
  }
}

class AllAddonList extends StatefulWidget {
  @override
  _AllAddonListState createState() => _AllAddonListState();
}

class _AllAddonListState extends State<AllAddonList> {
  GymStore store;
  @override
  Widget build(BuildContext context) {
    store = Provider.of<GymStore>(context);
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        title: Text(
          'WTF Powered ${locator<AppPrefs>().seeMorePt.getValue() ? 'Personal Training' : 'Fitness Activities'}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppConstants.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          store.getAllAddonClasses(context: context);
        },
        color: AppConstants.white,
        child: Consumer<GymStore>(
          builder: (context, store, child) => store.allAddonClasses != null
              ? store.allAddonClasses.data != null &&
                      store.allAddonClasses.data.isNotEmpty
                  ? Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: store.allAddonClasses.data
                            .where((e) =>
                                locator<AppPrefs>().seeMorePt.getValue()
                                    ? int.tryParse(e.isPt) == 1
                                    : int.tryParse(e.isPt) == 0)
                            .toList()
                            .length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Center(
                          child: LiveCard(
                            data: store.allAddonClasses.data
                                .where((e) =>
                                    locator<AppPrefs>().seeMorePt.getValue()
                                        ? int.tryParse(e.isPt) == 1
                                        : int.tryParse(e.isPt) == 0)
                                .toList()[index],
                            isFullView: true,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'No live Classes found',
                      ),
                    )
              : Loading(),
        ),
      ),
    );
  }
}
