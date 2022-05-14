import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wtf/100ms/argument/hms_dynamic_argument.dart';
import 'package:wtf/controller/gym_store.dart';

class HmsDynamicLinkScreen extends StatefulWidget {
  static const String routeName = '/hmsDynamicLinkScreen';

  const HmsDynamicLinkScreen({Key key}) : super(key: key);

  @override
  State<HmsDynamicLinkScreen> createState() => _HmsDynamicLinkScreenState();
}

class _HmsDynamicLinkScreenState extends State<HmsDynamicLinkScreen> {
  GymStore store;
  bool callMethod = true;
  final uiStream = BehaviorSubject<CheckHmsStatus>();

  Function(CheckHmsStatus) get setUiStream => uiStream.sink.add;

  Stream<CheckHmsStatus> get getUiStream => uiStream.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    uiStream.close();
  }

  void callData({@required HmsDynamicArgument arg}) {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        store.joinLiveSession(
            context: context,
            liveClassId: arg.data['liveClassId'],
            roomId: arg.data['roomId'],
            addonId: arg.data['addonId'],
            addonName: arg.data['addonName'],
            trainerId: arg.data['trainerId'],
            isDynamicLink: true);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    final HmsDynamicArgument args =
        ModalRoute.of(context).settings.arguments as HmsDynamicArgument;

    return Scaffold(
        body: Consumer<GymStore>(builder: (context, user, snapshot) {
      if (args != null ||
          args.data != null ||
          args.data['liveClassId'] != null) {
        callData(arg: args);
        return StreamBuilder(
          stream: uiStream,
          initialData: CheckHmsStatus.IN_PROGRESS,
          builder:
              (BuildContext context, AsyncSnapshot<CheckHmsStatus> snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                ),
                lottieImage(
                    name: animationName(snapshot.data),
                    width: 100,
                    repeat: snapshot.data != CheckHmsStatus.IN_PROGRESS
                        ? false
                        : true),
                ListTile(
                  title: Text(
                    getHeading(snapshot.data),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    getSubHeading(snapshot.data),
                    textAlign: TextAlign.center,
                  ),
                ),
                // ElevatedButton(onPressed: openCheckout, child: Text('Open')),
              ],
            );
          },
        );
      } else {
        return Center(
          child: Text('Something Went Wrong'),
        );
      }

      return Container();
    }));
  }

  String animationName(CheckHmsStatus status) {
    if (status == CheckHmsStatus.NO_PERMISSION ||
        status == CheckHmsStatus.TOKEN_NOT_FOUND ||
        status == CheckHmsStatus.INVALID_CLASS) {
      return 'failed';
    } else {
      return 'progress';
    }
  }

  String getHeading(CheckHmsStatus status) {
    if (status == CheckHmsStatus.NO_PERMISSION) {
      return 'Permission Failed';
    } else if (status == CheckHmsStatus.TOKEN_NOT_FOUND) {
      return 'Token Error';
    } else if (status == CheckHmsStatus.INVALID_CLASS) {
      return 'Invalid Class';
    } else {
      return 'In Progress';
    }
  }

  String getSubHeading(CheckHmsStatus status) {
    if (status == CheckHmsStatus.NO_PERMISSION) {
      return 'To Join the live class please enable your video and audio permission';
    } else if (status == CheckHmsStatus.TOKEN_NOT_FOUND) {
      return 'Live Class Token Not Found please try again later';
    } else if (status == CheckHmsStatus.INVALID_CLASS) {
      return 'This class is expired please contat your trainer';
    } else {
      return 'Please wait while we are connecting...';
    }
  }

  Widget lottieImage(
      {@required String name, double width = 80, bool repeat = true}) {
    return Container(
      width: width,
      height: width,
      child: Lottie.asset('assets/lottie/$name.json', repeat: repeat),
    );
  }
}

enum CheckHmsStatus {
  NO_PERMISSION,
  TOKEN_NOT_FOUND,
  INVALID_CLASS,
  TOKEN_FOUND,
  IN_PROGRESS
}
