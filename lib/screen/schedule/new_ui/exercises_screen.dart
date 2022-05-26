import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';

class ExercisesScreen extends StatefulWidget {
  static const String routeName = '/exercisesScreen';

  const ExercisesScreen({Key key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  double recommendedCircleHeight = 80.00;

  static const double EMPTY_SPACE = 10.0;
  ScrollController _scrollController;
  bool isScrolledToTop = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      //call setState only when values are about to change
      if(!isScrolledToTop) {
        setState(() {
          //reach the top
          isScrolledToTop = true;
        });
      }

    }else{
      //call setState only when values are about to change
      if(_scrollController.offset > EMPTY_SPACE && isScrolledToTop) {
        setState(() {
          //not the top
          isScrolledToTop = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: isScrolledToTop ? 0 : 4,
          backgroundColor: isScrolledToTop?Colors.transparent:AppColors.BACK_GROUND_BG,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Exercise'),
        ),
        body: Container(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey,
                                  Colors.transparent,
                                ])),
                      ),
                      Positioned(
                        right: 0,
                        child: SafeArea(
                          child: Container(
                            constraints: BoxConstraints(minWidth: 100),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:BorderRadius.only(topLeft: Radius.circular(100),bottomLeft: Radius.circular(100))
                            ),
                            child: Text('19:00:00',style:TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.white,
                  selectedTextColor: Colors.black,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: AppConstants.bgColor),
                  child: Text(
                    'Start Workout',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'Today\'s Schedule',
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        scheduleExerciseItem(),
                        scheduleExerciseItem(),
                        scheduleExerciseItem(),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: getList().length,
                      itemBuilder: (context,index){
                        ExModel item  = getList()[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            child: Text('Set ${index+1} (${item.label})',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),),padding: EdgeInsets.only(left: 16,right: 16),),
                        SizedBox(height: 12,),
                        itemCard(selected: index == 1,item: item)
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ));
  }

  Widget scheduleExerciseItem() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: recommendedCircleHeight,
            height: recommendedCircleHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xffE00303), Color(0xff485AFE)])),
            child: Container(
              margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),color: Colors.grey.shade200)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -10,

            child: Container(
              padding: EdgeInsets.only(top: 2,bottom: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE00303), Color(0xff485AFE)]),border: Border.all(width: 3,color: AppColors.BACK_GROUND_BG)
              ),
              child: Text('Chest'),
            ),
          )
        ],
      ),
    );
  }

  Widget itemCard({bool selected = false,ExModel item}){
    return Column(
      children: item.data.map((e) => Container(
        margin: EdgeInsets.only(left: 16,right: 16,bottom: 18),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(width: selected?1:0,color:!selected?Colors.transparent: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
                color: Colors.green,
              ),
              height: 80,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Text('4/4'),
                    padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 0),
                    title: Text('Skull Candy'),
                    trailing: Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Text("Resume"),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Set : 4'),
                        Text('Reps : 12,14,15,16')
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      )).toList(),
    );
  }

  List<ExModel> getList()=>[
    ExModel(label: 'Chest',data: [
      'Something','Something','Something',
    ]),
    ExModel(label: 'Cardio',data: [
      'Something',
    ]),
    ExModel(label: 'Biceps',data: [
      'Something','Something','Something','Something',
    ]),
    ExModel(label: 'Kabutar Dance',data: [
      'Something','Something','Something',
    ]),
  ];

}

class ExModel{
  String label;
  List<String> data;
  ExModel({this.data,this.label});
}


