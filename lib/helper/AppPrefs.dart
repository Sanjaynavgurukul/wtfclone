import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/model/User.dart';
import 'package:wtf/model/member_detils.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/model/preamble_model.dart';

class AppPrefs {
  final StreamingSharedPreferences preferences;

  AppPrefs(
    this.preferences,
  )   : isLoggedIn =
            preferences.getBool(PrefsConstants.logging, defaultValue: false),
        isFirstOpen =
            preferences.getBool(PrefsConstants.firstOpen, defaultValue: true),
        seeMorePt =
            preferences.getBool(PrefsConstants.seeMorePt, defaultValue: false),
        token =
            preferences.getString(PrefsConstants.authToken, defaultValue: ''),
        avatar = preferences.getString(
          PrefsConstants.avatar,
          defaultValue:
              'https://www.drupal.org/files/issues/default-avatar.png',
        ),
        userData = preferences.getCustomValue(
          PrefsConstants.userData,
          defaultValue: UserData(),
          adapter: JsonAdapter(
            deserializer: (val) => UserData.fromJson(val),
          ),
        ),
        memberData = preferences.getCustomValue(
          PrefsConstants.memberData,
          defaultValue: PreambleModel(),
          adapter: JsonAdapter(
            deserializer: (val) => PreambleModel.fromJson(val),
          ),
        ),
        activeScheduleData = preferences.getCustomValue(
          PrefsConstants.activeScheduleData,
          defaultValue: WorkoutScheduleData(),
          adapter: JsonAdapter(
            deserializer: (val) => WorkoutScheduleData.fromJson(val),
          ),
        ),
        selectedMyScheduleData = preferences.getCustomValue(
          PrefsConstants.selectedMyScheduleData,
          defaultValue: MyScheduleAddonData(),
          adapter: JsonAdapter(
            deserializer: (val) => MyScheduleAddonData.fromJson(val),
          ),
        ),
        fcmToken =
            preferences.getString(PrefsConstants.fcmToken, defaultValue: ''),
        dateAdded = preferences.getString(PrefsConstants.dateAdded,
            defaultValue: DateTime.now().toIso8601String()),
        // currentWorkoutDaySelected = preferences.getString(
        //   PrefsConstants.currentWorkoutDaySelected,
        //   defaultValue: DateTime.now().toString(),
        // ),
        userEmail =
            preferences.getString(PrefsConstants.userEmail, defaultValue: ''),
        gender = preferences.getString(PrefsConstants.gender, defaultValue: ''),
        selectedWorkoutDate = preferences
            .getString(PrefsConstants.selectedWorkoutDate, defaultValue: ''),
        phoneNumber =
            preferences.getString(PrefsConstants.phoneNumber, defaultValue: ''),
        selectedSubmission = preferences
            .getString(PrefsConstants.selectedSubmission, defaultValue: ''),
        selectedMySchedule = preferences
            .getString(PrefsConstants.selectedMySchedule, defaultValue: ''),
        selectedMyScheduleName = preferences
            .getString(PrefsConstants.selectedMyScheduleName, defaultValue: ''),
        otp = preferences.getString(PrefsConstants.otp, defaultValue: ''),
        userName =
            preferences.getString(PrefsConstants.userName, defaultValue: ''),
        language =
            preferences.getString(PrefsConstants.language, defaultValue: 'en'),
        liveClassParticipantId = preferences.getString(
            PrefsConstants.liveClassParticipantId,
            defaultValue: 'en'),
        livePtVerificationId = preferences
            .getString(PrefsConstants.livePtVerificationId, defaultValue: 'en'),
        liveExerciseId = preferences.getString(PrefsConstants.liveExerciseId,
            defaultValue: 'en'),
        memberAdded = preferences.getBool(PrefsConstants.updateMemberData,
            defaultValue: false),
        initialLocationAsked = preferences.getBool(PrefsConstants.initialLocationAsked,
            defaultValue: false),
        memberId =
            preferences.getString(PrefsConstants.userId, defaultValue: ''),
        type1 = preferences.getString(PrefsConstants.type1, defaultValue: ''),
        type2 = preferences.getString(PrefsConstants.type2, defaultValue: ''),
        lat = preferences.getString(PrefsConstants.lat,
            defaultValue: '28.596669322602807'),
        lng = preferences.getString(PrefsConstants.lng,
            defaultValue: '77.32866249084584'),
        globalTimer =
            preferences.getInt(PrefsConstants.globalTimer, defaultValue: 0),
        exerciseData = preferences.getString(PrefsConstants.exerciseData,
            defaultValue: ''),
        exerciseOn =
            preferences.getBool(PrefsConstants.exerciseOn, defaultValue: false),
        inProgressEx = preferences.getString(PrefsConstants.inProgressEx,
            defaultValue: ''),
        exerciseUid =
            preferences.getString(PrefsConstants.exerciseUid, defaultValue: ''),
        exercisePause = preferences.getBool(PrefsConstants.exercisePause,
            defaultValue: false),
        exerciseSet =
            preferences.getInt(PrefsConstants.exerciseSet, defaultValue: 1),
        startExTimer =
            preferences.getInt(PrefsConstants.startExTimer, defaultValue: 0),
        liveClassTimerDate =
            preferences.getInt(PrefsConstants.liveClassTimerDate, defaultValue: 0),

        //New DPref Data
        exData =
        preferences.getString(PrefsConstants.exData, defaultValue: '{}'),
        newScheduleGlobalTime =
        preferences.getInt(PrefsConstants.newScheduleGlobalTime, defaultValue: 0),

        address = preferences.getString(PrefsConstants.address,
            defaultValue: 'Noida Sector 8');


  final Preference<bool> isLoggedIn;
  final Preference<bool> isFirstOpen;
  final Preference<bool> seeMorePt;

  final Preference<String> token;
  final Preference<String> liveClassParticipantId;
  final Preference<String> livePtVerificationId;
  final Preference<String> liveExerciseId;
  final Preference<String> fcmToken;
  final Preference<String> phoneNumber;
  final Preference<String> dateAdded;
  final Preference<String> userEmail;
  final Preference<UserData> userData;
  final Preference<String> gender;
  final Preference<bool> memberAdded;

  // final Preference<String> currentWorkoutDaySelected;
  final Preference<String> selectedMySchedule;
  final Preference<String> selectedSubmission;
  final Preference<String> selectedMyScheduleName;
  final Preference<String> selectedWorkoutDate;
  final Preference<MyScheduleAddonData> selectedMyScheduleData;
  Preference<PreambleModel> memberData;
  final Preference<WorkoutScheduleData> activeScheduleData;
  final Preference<String> avatar;
  final Preference<String> otp;
  final Preference<String> memberId;
  final Preference<String> language;
  final Preference<String> userName;
  final Preference<String> type1;
  final Preference<String> type2;
  final Preference<String> lat;
  final Preference<String> lng;
  final Preference<String> address;

  final Preference<int> globalTimer;
  final Preference<bool> exerciseOn;
  final Preference<String> exerciseData;

  final Preference<String> exerciseUid;
  final Preference<String> inProgressEx;
  final Preference<bool> exercisePause;
  final Preference<int> exerciseSet;
  final Preference<int> startExTimer;
  final Preference<int> liveClassTimerDate;
  final Preference<bool> initialLocationAsked;
  final Preference<int> newScheduleGlobalTime;
  final Preference<String> exData;

  Future<bool> setBool(String key, bool value) async {
    printBefore(value: value, key: key);
    return await preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    printBefore(value: value, key: key);
    return await preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    printBefore(value: value, key: key);
    return await preferences.setInt(key, value);
  }

  Future<void> clear() async {
    await preferences.clear();
  }

  Future<bool> setString(String key, String value) async {
    printBefore(value: value, key: key);
    return await preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    printBefore(value: value, key: key);
    return await preferences.setStringList(key, value);
  }

  Future<bool> setCustomValue(
      String key, value, PreferenceAdapter<dynamic> adapter) async {
    printBefore(value: value, key: key);
    return await preferences.setCustomValue(key, value, adapter: adapter);
  }

  printBefore({String key, value}) =>
      print('Saving Key: $key &  value: $value');
}

class PrefsConstants {
  static const String logging = 'isLoggedIn';
  static const String firstOpen = 'isFirstOpen';
  static const String isReadOnlyModeActive = 'isReadOnlyModeActive';
  static const String seeMorePt = 'seeMorePt';
  static const String addingClothToTrip = 'addingClothToTrip';
  static const String selectedMySchedule = 'selectedMySchedule';
  static const String selectedMyScheduleName = 'selectedMyScheduleName';
  static const String hideClothActions = 'hideClothActions';
  static const String authToken = 'authToken';
  static const String userData = 'userData';
  static const String memberData = 'memberData';
  static const String activeScheduleData = 'activeScheduleData';
  static const String selectedMyScheduleData = 'selectedMyScheduleData';
  static const String user = 'user';
  static const String adsRecentSearches = 'adsRecentSearches';
  static const String remoteConfig = 'remoteConfig';
  static const String language = 'language';
  static const String liveClassParticipantId = 'liveClassParticipantId';
  static const String livePtVerificationId = 'livePtVerificationId';
  static const String liveExerciseId = 'liveExerciseId';
  static const String updateMemberData = 'updateMemberData';
  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String profileStatus = 'profile_status';
  static const String webViewUrl = 'webViewUrl';
  static const String lastLogin = 'lastLogin';
  static const String webViewTitle = 'webViewTitle';
  static const String avatar = 'avatar';
  static const String searchType = 'searchType';
  static const String productRecentSearches = 'productRecentSearches';
  static const String cropRecentSearches = 'cropRecentSearches';
  static const String isAnEvent = 'isAnEvent';
  static const String fcmToken = 'fcmToken';
  static const String dateAdded = 'dateAdded';
  static const String currentWorkoutDaySelected = 'currentWorkoutDaySelected';
  static const String currency = 'currency';
  static const String currencySymbol = 'currencySymbol';
  static const String dynamicLinkPostId = 'dynamicLinkPostId';
  static const String dynamicLinkReferredBy = 'dynamicLinkReferredBy';
  static const String dynamicLinkReferredByCode = 'dynamicLinkReferredByCode';
  static const String cartSessionId = 'cartSessionId';
  static const String avatarThumb = 'avatarThumb';
  static const String selectedCardBgColor = 'selectedCardBgColor';
  static const String selectedPrimaryColor = 'selectedPrimaryColor';
  static const String selectedPrimaryColor2 = 'selectedPrimaryColor2';
  static const String humidity = 'humidity';
  static const String weather = 'weather';
  static const String rainfall = 'rainfall';
  static const String place = 'place';
  static const String phoneNumber = 'phoneNumber';
  static const String selectedSubmission = 'selectedSubmission';
  static const String otp = 'otp';
  static const String temperature = 'temperature';
  static const String userString = 'userString';
  static const String allAdsIndex = 'allAdsIndex';
  static const String userEmail = 'userEmail';
  static const String gender = 'gender';
  static const String selectedWorkoutDate = 'selectedWorkoutDate';
  static const String type1 = 'type1';
  static const String type2 = 'type2';
  static const String diet_category_id = 'dietcatid';
  static const String lat = 'lat';
  static const String lng = 'lng';
  static const String address = 'currentAddress';
  static const String initialLocationAsked = 'initialLocationAsked';

  //Global Timer :D
  static const String globalTimer = 'globalTimer';
  static const String exerciseOn = 'exerciseOn';

  //Exercise Pref Data :D
  static const String mainEx = 'mainEx';
  static const String exDetail = 'exDetail';

  static const String exerciseData = 'exerciseData';

  static const String exerciseUid = 'exerciseUid';
  static const String exerciseSet = 'exerciseSet';
  static const String exercisePause = 'exercisePause';
  static const String inProgressEx = 'inProgressEx';
  static const String startExTimer = 'startExTimer';
  static const String liveClassTimerDate = 'liveClassTimerDate';

  static const String newScheduleGlobalTime = 'newScheduleGlobalTime';
  static const String exData = 'exData';
}
