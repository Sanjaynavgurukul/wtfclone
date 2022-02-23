import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging_platform_interface/src/remote_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/auth_controller.dart';
import 'package:wtf/controller/dynamic_links.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/helper/firebase_cloud_messaging_wapper.dart';
import 'package:wtf/helper/network_utils.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/screen/calculators/bmr_calculator/bmr_state.dart';
import 'package:wtf/screen/calculators/body_calculator/bodyFat_state.dart';
import 'package:wtf/screen/calculators/calories_counter/calorie_state.dart';
import 'package:wtf/screen/landing/landing_screen.dart';

import 'helper/AppPrefs.dart';
import 'helper/NotificationHelper.dart';
import 'helper/app_constants.dart';
import 'helper/colors.dart';
import 'helper/navigation.dart';
import 'helper/routes.dart';

final GetIt locator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await setupLocator();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: '123456',
        channelName: 'WTF',
        channelDescription: 'WTF Notifications',
        defaultColor: AppConstants.primaryColor,
        playSound: true,
        soundSource: 'resource://raw/res_morph_power_rangers',
        ledColor: Colors.white,
      )
    ],
  );
  // SharedPref.pref = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppConstants.primaryColor,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.light : Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, FirebaseCloudMessagingDelegate {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      initNotifications();
      FirebaseCloudMessagagingWapper()
        ..init()
        ..delegate = this;
    });
    locator<DynamicLinkService>().handleDynamicLinks();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('LIFE CYCLE STATE CHANGED::::: $state');
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      AwesomeNotifications().cancelAll();
    } else if (state == AppLifecycleState.resumed) {
    } else {}
  }

  Future<void> initNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/ic_notification');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  Future<dynamic> onDidReceiveLocalNotification(
    int a,
    String ab,
    String abc,
    String abcd,
  ) async {}
  // {notification: {title: We received your order, body: Thank you, we received your order. Your order will be delivered in next 2-3 working days}, data: {queryParams: , id: 604b586c5751410008fd541e, type: order-mgmt, image: https://s3.ap-south-1.amazonaws.com/cdn.fasalsetu.com/products/7ec4230a-4a6a-419e-b520-79508664d9cf.png, route: /orders}}
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      try {
        var jsonResp = json.decode(payload.toString());
        String orderType = jsonResp['data']['type'];
        String image = jsonResp['data']['image'];
        switch (orderType) {
          case 'order-mgmt':
            print('inside order management');
            String orderId = jsonResp['data']['id'];
            // locator<NavigationService>().navigateTo(RouteList.myOrders);
            break;
          case 'pay-mgmt':
            break;
          case 'product-notification':
            break;
          case 'notification':
            break;
          case 'visits':
            break;
        }
      } catch (e) {
        print('NOTIFICATION-Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(create: (_) => AuthController()),
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<GymStore>(create: (_) => GymStore()),
        ChangeNotifierProvider<UserStore>(create: (_) => UserStore()),
        ChangeNotifierProvider(
          create: (context) => BmrState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalorieState(),
        ),
        ChangeNotifierProvider(
          create: (context) => BodyState(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(480, 960),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WTF',
          darkTheme: ThemeData(
            scaffoldBackgroundColor: AppColors.BACK_GROUND_BG,
            brightness: Brightness.dark,
            dividerColor: Color(0xff1d1f20),
            accentColor: AppConstants.primaryColor,
            splashColor: AppConstants.primaryColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.PRIMARY_COLOR,
              ),
            ),
            primarySwatch:
                AppColors.generateMaterialColor(AppConstants.primaryColor),
            fontFamily: Fonts.RALEWAY,
          ),
          themeMode: ThemeMode.dark,
          // initialRoute: Routes.loader,
          home: LandingScreen(),
          // Routes.splash,
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }

  @override
  onMessage(Map<String, dynamic> message, RemoteNotification notification) {
    print('[app.dart] onMessage Pushnotification: $message');
    _saveMessage(message, notification);
  }

  void _saveMessage(
      Map<String, dynamic> message, RemoteNotification notification) {
    showAndroidNotification(message, notification);
  }

  Future<void> showAndroidNotification(
      Map<String, dynamic> jsonResp, RemoteNotification notification) async {
    String bigPicturePath = jsonResp['image'];
    if (bigPicturePath != null) {
      bigPicturePath = await NotificationHelper()
          .downloadAndSaveFile(bigPicturePath, 'notificationImg');
    }
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '123456',
      'WTF',
      'WTF Member',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      styleInformation: bigPicturePath != null && bigPicturePath.isNotEmpty
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(bigPicturePath),
              largeIcon: FilePathAndroidBitmap(bigPicturePath),
              hideExpandedLargeIcon: false,
              contentTitle: notification.title,
              htmlFormatContentTitle: true,
              summaryText: notification.body,
              htmlFormatSummaryText: true,
            )
          : BigTextStyleInformation(''),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    try {
      print('JSON::noti ${jsonResp['notification']}');
      print('JSON::data ${jsonResp['data']}');
    } catch (e) {
      print('NOTIFICATION ERROR: $e');
    }
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: json.encode(jsonResp),
    );
  }
}

Future<void> setupLocator() async {
  final preferences = await StreamingSharedPreferences.instance;
  locator.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
  locator.registerLazySingleton<FirebaseCloudMessagagingWapper>(
      () => FirebaseCloudMessagagingWapper());
  locator.registerLazySingleton<NetworkUtil>(() => NetworkUtil());
  locator.registerLazySingleton<DynamicLinkService>(() => DynamicLinkService());
  locator.registerFactory<GymStore>(() => GymStore());
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}
