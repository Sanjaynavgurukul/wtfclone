import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:wtf/screen/DiscoverScreen.dart';
import 'package:wtf/screen/addon/BookSession.dart';
import 'package:wtf/screen/addon/BookingSuccess.dart';
import 'package:wtf/screen/addon/Slot/choose_slot_screen.dart';
import 'package:wtf/screen/addon/Slot/choose_slot_screen_addon.dart';
import 'package:wtf/screen/addon/addon_cat.dart';
import 'package:wtf/screen/addon/all_addon_list.dart';
import 'package:wtf/screen/addon/buy_session.dart';
import 'package:wtf/screen/addon/live_classes.dart';
import 'package:wtf/screen/addon/powered_pages.dart';
import 'package:wtf/screen/addon/pt_pages.dart';
import 'package:wtf/screen/addon/schedule_slots_screen.dart';
import 'package:wtf/screen/attendance/attendance.dart';
import 'package:wtf/screen/attendance/qrScanner.dart';
import 'package:wtf/screen/auth/forgot_password.dart';
import 'package:wtf/screen/auth/login.dart';
import 'package:wtf/screen/auth/login_email.dart';
import 'package:wtf/screen/auth/register.dart';
import 'package:wtf/screen/calculators/bmr_calculator/bmr_calculator.dart';
import 'package:wtf/screen/calculators/bmr_calculator/bmr_calculator_result.dart';
import 'package:wtf/screen/calculators/body_calculator/bodyFat_cal.dart';
import 'package:wtf/screen/calculators/body_calculator/bodyFat_cal_result.dart';
import 'package:wtf/screen/calculators/body_calculator/body_calculator.dart';
import 'package:wtf/screen/calculators/calories_counter/calories_counter.dart';
import 'package:wtf/screen/calculators/calories_counter/calories_counter_result.dart';
import 'package:wtf/screen/change_diet/change_diet.dart';
import 'package:wtf/screen/change_diet/choose_plan.dart';
import 'package:wtf/screen/change_diet/diet_details.dart';
import 'package:wtf/screen/coin/allcoin_screen.dart';
import 'package:wtf/screen/coin/coin_screen.dart';
import 'package:wtf/screen/coin/point_history.dart';
import 'package:wtf/screen/coin/redeem_history.dart';
import 'package:wtf/screen/coin/shopping_screen.dart';
import 'package:wtf/screen/event/EventDetails.dart';
import 'package:wtf/screen/event/event_submissions.dart';
import 'package:wtf/screen/event/submission_detail.dart';
import 'package:wtf/screen/force_update/force_update_screen.dart';
import 'package:wtf/screen/gym/gym_cat.dart';
import 'package:wtf/screen/gym/gym_category_screen.dart';
import 'package:wtf/screen/gym/gym_membership_plan_page.dart';
import 'package:wtf/screen/gym/membership_page.dart';
import 'package:wtf/screen/home/home.dart';
import 'package:wtf/screen/home/notifications/notifications.dart';
import 'package:wtf/screen/home_screen.dart';
import 'package:wtf/screen/loader.dart';
import 'package:wtf/screen/my_wtf.dart';
import 'package:wtf/screen/nutrition/congrats_screen.dart';
import 'package:wtf/screen/nutrition/diet_schedule.dart';
import 'package:wtf/screen/schedule/MainWorkoutScreen.dart';
import 'package:wtf/screen/schedule/exercise/exercise.dart';
import 'package:wtf/screen/schedule/exercise/exercise_start/exercise_start.dart';
import 'package:wtf/screen/schedule/my_schedule.dart';
import 'package:wtf/screen/schedule/new/main_workouts.dart';
import 'package:wtf/screen/schedule/workout_complete/workout_complete.dart';
import 'package:wtf/screen/search_screen.dart';
import 'package:wtf/screen/side_bar_drawer/my_subscription.dart';
import 'package:wtf/screen/side_bar_drawer/my_transaaction.dart';
import 'package:wtf/screen/side_bar_drawer/profile.dart';
import 'package:wtf/screen/side_bar_drawer/shift_trainer.dart';
import 'package:wtf/screen/splash.dart';
import 'package:wtf/screen/statistics/statistics.dart';
import 'package:wtf/screen/subscriptions/ActiveSubscriptionScreen.dart';
import 'package:wtf/screen/subscriptions/booking_summary.dart';
import 'package:wtf/screen/subscriptions/booking_summary_add_on.dart';
import 'package:wtf/screen/subscriptions/booking_summary_events.dart';
import 'package:wtf/screen/subscriptions/buy_subscription_screen.dart';
import 'package:wtf/screen/subscriptions/payment_process.dart';
import 'package:wtf/screen/user/update_fitness_profile.dart';
import 'package:wtf/screen/user/user_details.dart';

class Routes {
  static const String loader = '/loader';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String loginEmail = '/loginEmail';
  static const String register = '/register';
  static const String forgotPaswword = '/forgotPassword';
  static const String resetPaswword = '/resetPassword';
  static const String userDetail = '/userDetail';
  static const String homePage = '/homePage';
  static const String eventDetails = '/eventDetails';
  static const String eventSubmissions = '/eventSubmissions';
  static const String submissionDetail = '/submissionDetail';
  static const String discoverNow = '/discoverNow';
  static const String discover = '/discover';
  static const String searchScreen = '/searchPage';
  static const String buyMemberShipPage = '/buyMemberShipPage';
  static const String bookingSummaryEvent = '/bookingSummaryEvent';
  static const String membershipPlanPage = '/membershipPlanPage';
  static const String allLiveAddons = '/allLiveAddons';
  static const String allAddons = '/allAddons';
  static const String scheduleSlotPage = '/scheduleSlotPage';
  static const String chooseSlotScreen = '/chooseSlotScreen';
  static const String chooseSlotScreenAddon = '/chooseSlotScreenAddon';
  static const String buySubscriptionScreen = '/buySubscriptionScreen';
  static const String bookingSummaryScreen = '/bookingSummaryScreen';
  static const String bookingSummaryAddOn = '/bookingSummaryAddOn';
  static const String mySchedule = '/mySchedule';
  static const String ptClassPage = '/ptClassPage';
  static const String poweredPages = '/poweredPages';
  static const String profile = '/profile';
  static const String myWtf = '/myWtf';
  static const String myTransaction = '/myTransaction';
  static const String mySubscription = '/mySubscription';
  static const String notifications = '/notifications';
  static const String exercise = '/exercise';
  static const String exerciseStart = '/exerciseStart';
  static const String bookSession = '/bookSession';
  static const String exerciseDone = '/exerciseDone';
  static const String purchaseDone = '/purchaseDone';
  static const String eventPurchaseDone = '/eventPurchaseDone';
  static const String calorieCounter = '/calorieCounter';
  static const String calorieCounterResult = '/calorieCounterResult';
  static const String activeSubscriptionScreen = '/activeSubscriptionScreen';
  static const String bodyCalculator = '/bodyCalculator';
  static const String myStats = '/myStats';
  static const String bmrCalculatorResult = '/bmrCalculatorResult';
  static const String shiftTrainer = '/shiftTrainer';
  static const String buySession = '/buySession';
  static const String bmrCalculator = '/bmrCalculator';
  static const String mainAttendance = '/mainAttendance';
  static const String scanAttendance = '/scanAttendance';
  static const String dashboard = '/dashboard';
  static const String bodyFatCal = '/bodyFatCal';
  static const String bodyFatCalResult = '/bodyFatCalResult';
  static const String myDietSchedule = '/myDietSchedule';
  static const String mainWorkoutScreen = '/workoutMainScreen';
  static const String ptIntro = '/ptIntro';
  static const String updateFitnessProfile = '/updateFitnessProfile';
  static const String coin = '/coin';
  static const String allcoin = '/allcoin';
  static const String pointHistory = '/pointHistory';
  static const String redeemHistory = '/redeemHistory';
  static const String shoppingScreen = '/shoppingScreen';
  static const String congratsScreen = '/congratsScreen';
  static const String changeDietScreen = ChangeDiet.routeName;
  static const String choosePlanScreen = ChoosePlan.routeName;
  static const String dietDetailScreen = DietDetails.routeName;
  static const String forceUpdateScreen = ForceUpdateScreen.routeName;
  static const String gymCategoryScreen = GymCategoryScreen.routeName;
  static const String addonsCat = AddonsCat.routeName;
  static const String gymCat = GymCat.routeName;
  static const String paymentProcess = PaymentProcess.routeName;
  static const String mainWorkout = MainWorkout.routeName;
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.paymentProcess:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
          widget: PaymentProcess(),
          settings: settings,
        )
            : CupertinoPageRoute(
            builder: (context) => PaymentProcess(), settings: settings);
      case Routes.mainWorkout:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
          widget: MainWorkout(),
          settings: settings,
        )
            : CupertinoPageRoute(
            builder: (context) => MainWorkout(), settings: settings);
      case Routes.changeDietScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChangeDiet(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ChangeDiet(), settings: settings);
      case Routes.gymCategoryScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: GymCategoryScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => GymCategoryScreen(), settings: settings);
      case Routes.choosePlanScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChoosePlan(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ChoosePlan(), settings: settings);
      case Routes.dietDetailScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DietDetails(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => DietDetails(), settings: settings);
      case Routes.forceUpdateScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForceUpdateScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ForceUpdateScreen(), settings: settings);
      case Routes.loader:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: LoaderPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => LoaderPage(), settings: settings);
      case Routes.splash:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SplashPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SplashPage(), settings: settings);
      case Routes.login:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: LoginPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => LoginPage(), settings: settings);
      case Routes.loginEmail:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: LoginEmail(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => LoginEmail(), settings: settings);
      case Routes.updateFitnessProfile:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UpdateFitnessProfile(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => UpdateFitnessProfile(),
                settings: settings);
      case Routes.forgotPaswword:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgotPasswordPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ForgotPasswordPage(), settings: settings);
      // case Routes.resetPaswword:
      //   return Platform.isAndroid ? _FadedTransitionRoute(widgetb (_) => ResetPasswordPage(),settings: settings,);
      case Routes.register:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegisterPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => RegisterPage(), settings: settings);
      case Routes.userDetail:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: UserDetailsPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => UserDetailsPage(), settings: settings);
      case Routes.eventDetails:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EventDetails(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => EventDetails(), settings: settings);
      case Routes.eventSubmissions:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EventSubmissionScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => EventSubmissionScreen(),
                settings: settings);
      case Routes.submissionDetail:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SubmissionDetail(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SubmissionDetail(), settings: settings);
      case Routes.ptIntro:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PTIntro(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PTIntro(), settings: settings);
      case Routes.homePage:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: HomeScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => HomeScreen(), settings: settings);
      case Routes.searchScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SearchScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SearchScreen(), settings: settings);
      case Routes.discoverNow:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DiscoverScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => DiscoverScreen(), settings: settings);
      case Routes.myWtf:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MyWtf(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => MyWtf(), settings: settings);
      case Routes.mySubscription:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MySubscription(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => MySubscription(), settings: settings);
      case Routes.myTransaction:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MyTransaction(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => MyTransaction(), settings: settings);
      case Routes.myDietSchedule:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DietSchedule(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => DietSchedule(), settings: settings);
      case Routes.profile:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: Profile(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => Profile(), settings: settings);
      case Routes.notifications:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: Notifications(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => Notifications(), settings: settings);
      case Routes.bookSession:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BookSession(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BookSession(), settings: settings);
      case Routes.buyMemberShipPage:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BuyMemberShipPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BuyMemberShipPage(), settings: settings);
      case Routes.bookingSummaryEvent:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BookingSummaryEvents(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BookingSummaryEvents(),
                settings: settings);
      case Routes.membershipPlanPage:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: GymMembershipPlanPage(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => GymMembershipPlanPage(),
                settings: settings);
      case Routes.allLiveAddons:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: LiveClasses(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => LiveClasses(),
                settings: settings,
              );
      case Routes.ptClassPage:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PTPages(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PTPages(),
                settings: settings,
              );
      case Routes.poweredPages:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PoweredPages(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PoweredPages(),
                settings: settings,
              );
      case Routes.allAddons:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AllAddonList(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => AllAddonList(), settings: settings);
      case Routes.scheduleSlotPage:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScheduleSlotScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ScheduleSlotScreen(), settings: settings);
      case Routes.chooseSlotScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChooseSlotScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ChooseSlotScreen(), settings: settings);
      case Routes.chooseSlotScreenAddon:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ChooseSlotAddonScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ChooseSlotAddonScreen(),
                settings: settings);
      case Routes.buySubscriptionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BuySubscriptionScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BuySubscriptionScreen(),
                settings: settings);
      case Routes.bookingSummaryScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BookingSummaryScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BookingSummaryScreen(),
                settings: settings);
      case Routes.bookingSummaryAddOn:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BookingSummaryAddOn(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BookingSummaryAddOn(),
                settings: settings);
      case Routes.mySchedule:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MyScheduleScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => MyScheduleScreen(), settings: settings);
      case Routes.mainWorkoutScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MainWorkoutScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => MainWorkoutScreen(), settings: settings);
      case Routes.exercise:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ExerciseDetails(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ExerciseDetails(), settings: settings);
      case Routes.exerciseStart:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ExerciseStart(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ExerciseStart(), settings: settings);
      case Routes.exerciseDone:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: WorkoutComplete(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => WorkoutComplete(), settings: settings);
      case Routes.purchaseDone:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PurchaseDone(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PurchaseDone(), settings: settings);
      case Routes.eventPurchaseDone:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EventPurchaseDone(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => EventPurchaseDone(), settings: settings);
      case Routes.calorieCounter:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CaloriesCounter(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CaloriesCounter(), settings: settings);
      case Routes.calorieCounterResult:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CaloriesCounterResult(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CaloriesCounterResult(),
                settings: settings);
      case Routes.bodyCalculator:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BodyCalculator(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BodyCalculator(), settings: settings);
      case Routes.myStats:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: Statistics(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => Statistics(), settings: settings);
      case Routes.activeSubscriptionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ActiveSubscriptionScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ActiveSubscriptionScreen(),
                settings: settings);
      case Routes.bmrCalculatorResult:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BMRCalculatorResult(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BMRCalculatorResult(),
                settings: settings);
      case Routes.shiftTrainer:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ShiftTrainer(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ShiftTrainer(), settings: settings);
      case Routes.discover:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DiscoverScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => DiscoverScreen(), settings: settings);
      case Routes.buySession:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BuySession(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BuySession(), settings: settings);
      case Routes.bmrCalculatorResult:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BMRCalculatorResult(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BMRCalculatorResult(),
                settings: settings);
      case Routes.bmrCalculator:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BMRCalculator(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BMRCalculator(), settings: settings);
      case Routes.mainAttendance:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: Attendance(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => Attendance(), settings: settings);
      case Routes.scanAttendance:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: QRScanner(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => QRScanner(), settings: settings);
      case Routes.dashboard:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: DashboardScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => DashboardScreen(), settings: settings);
      case Routes.bodyFatCal:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BodyFatCalculator(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BodyFatCalculator(), settings: settings);
      case Routes.bodyFatCalResult:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BodyFatCalResult(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => BodyFatCalResult(), settings: settings);
      case Routes.coin:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CoinScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CoinScreen(), settings: settings);
      case Routes.allcoin:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AllCoinScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => AllCoinScreen(), settings: settings);
      case Routes.pointHistory:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PointHistory(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PointHistory(), settings: settings);
      case Routes.redeemHistory:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RedeemHistory(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => RedeemHistory(), settings: settings);
      case Routes.shoppingScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ShoppingScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ShoppingScreen(), settings: settings);
      case Routes.congratsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CongtarsScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CongtarsScreen(), settings: settings);
      default:
        return null;
    }
  }

  static PageRouteBuilder _buildRouteFade(
      RouteSettings settings, Widget builder) {
    return Platform.isAndroid
        ? _FadedTransitionRoute(
            settings: settings,
            widget: builder,
          )
        : CupertinoPageRoute(builder: (context) => builder, settings: settings);
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: Duration(milliseconds: 600),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}
