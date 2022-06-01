import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/schedule/new/ex_start_screen.dart';
import 'package:wtf/screen/schedule/new_ui/argument/ex_detail_argument.dart';
import 'package:wtf/widget/progress_loader.dart';

class ExerciseDetailScreen extends StatefulWidget {
  static const String routeName = '/exerciseDetailScreen';

  const ExerciseDetailScreen({Key key}) : super(key: key);

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ExerciseDetailArgument args =
        ModalRoute.of(context).settings.arguments as ExerciseDetailArgument;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Call Trainer',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(width: 1, color: Colors.white),
                      color: AppConstants.bgColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'STOP',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: args == null
            ? Center(
                child: Loading(),
              )
            : args.mainData == null
                ? Center(
                    child: Text('No Data Found'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // ExerciseStartButtons(),
                        SizedBox(
                          height: 15,
                        ),
                        VideoPlayerScreen(
                          url: '${args.mainData.video}',
                          isPlaying: (val) {},
                          isEx: true,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: ListTile(
                                    title: Text(
                                  '${args.mainData.wo_name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 24),
                                )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.white,
                                          const Color(0xFF02BB9F)
                                        ],
                                        // stops: [0.9, 0.4]
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Html(
                            data: args.mainData.description ?? ' - - -',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ));
  }
}
