import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class SocialAuthService {
  Future<ResponseData<GoogleKeys>> googleSignin() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleuser.authentication;

      print('apis');
      return ResponseData<GoogleKeys>(
          isSuccessed: true,
          message: 'success',
          data: GoogleKeys(
              accessToken: googleAuth.accessToken,
              email: googleuser.email,
              name: googleuser.displayName));
    } catch (e) {
      throw e;
    }
  }

  // static Future<void> check() async {
  //   return AppleSignInAvailable(await SignInApple.isAvailable());
  // }

  // Future<ResponseData<List<String>>> facebookSignin() async {
  //   final fb = FacebookLogin();
  //
  //   final res = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //       final FacebookAccessToken accessToken = res.accessToken;
  //
  //       final email = await fb.getUserEmail();
  //       final name = await fb.getUserProfile();
  //
  //       if (email != null) {
  //         return ResponseData(
  //           isSuccessed: true,
  //           message: 'Success',
  //           data: [email, name.name],
  //         );
  //       }
  //       return ResponseData(
  //         isSuccessed: false,
  //         message: 'Email not found',
  //       );
  //
  //     case FacebookLoginStatus.cancel:
  //       return ResponseData(
  //         isSuccessed: false,
  //         message: 'Error',
  //       );
  //
  //     case FacebookLoginStatus.error:
  //       return ResponseData(isSuccessed: false, message: 'Error');
  //   }
  // }
}

class GoogleKeys {
  String accessToken;
  String email;
  String name;
  GoogleKeys({
    this.accessToken,
    this.email,
    this.name,
  });

  GoogleKeys copyWith({String accessToken, String idToken, String name}) {
    return GoogleKeys(
        accessToken: accessToken ?? this.accessToken,
        email: idToken ?? this.email,
        name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'idToken': email,
    };
  }

  factory GoogleKeys.fromMap(Map<String, dynamic> map) {
    return GoogleKeys(
      accessToken: map['accessToken'],
      email: map['idToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleKeys.fromJson(String source) =>
      GoogleKeys.fromMap(json.decode(source));

  @override
  String toString() => 'GoogleKeys(accessToken: $accessToken, idToken: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoogleKeys &&
        other.accessToken == accessToken &&
        other.email == email;
  }

  @override
  int get hashCode => accessToken.hashCode ^ email.hashCode;
}

class ResponseData<T> {
  ResponseData({
    this.message,
    this.isSuccessed,
    this.data,
  });

  String message;
  bool isSuccessed;
  T data;

  ResponseData copyWith({
    String message,
    T data,
    bool isSuccessed,
  }) =>
      ResponseData(
        message: message ?? this.message,
        isSuccessed: isSuccessed ?? this.isSuccessed,
        data: data ?? this.data,
      );
}
