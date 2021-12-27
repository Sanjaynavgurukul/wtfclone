import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_constants.dart';

class FlashHelper {
  static Completer<BuildContext> _buildCompleter = Completer<BuildContext>();

  static void init(BuildContext context) {
    if (_buildCompleter?.isCompleted == false) {
      _buildCompleter.complete(context);
    }
  }

  static void dispose() {
    if (_buildCompleter?.isCompleted == false) {
      _buildCompleter.completeError(FlutterError('disposed'));
    }
    _buildCompleter = Completer<BuildContext>();
  }

  static Future<T> toast<T>(String message) async {
    var context = await _buildCompleter.future;
    return showFlash<T>(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (_, controller) {
        return Flash.dialog(
          controller: controller,
          alignment: const Alignment(0, 0.5),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          enableDrag: false,
          backgroundColor: Colors.black87,
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(message),
            ),
          ),
        );
      },
    );
  }

  static Color _backgroundColor(BuildContext context) =>
      AppConstants.nearlyBlack;

  static TextStyle _titleStyle(BuildContext context, [Color color]) =>
      AppConstants.customStyle(
        color: AppConstants.white,
        size: 15.0,
        weight: FontWeight.bold,
      );

  static TextStyle _contentStyle(BuildContext context, [Color color]) =>
      AppConstants.customStyle(
        color: AppConstants.white,
        size: 15.0,
        weight: FontWeight.bold,
      );

  static Future<T> successBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.check_circle, color: Colors.green[300]),
            leftBarIndicatorColor: Colors.green[300],
          ),
        );
      },
    );
  }

  static Future<T> informationBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.info_outline, color: Colors.blue[300]),
            leftBarIndicatorColor: Colors.blue[300],
          ),
        );
      },
    );
  }

  static Future<T> errorBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.warning, color: Colors.red[300]),
            leftBarIndicatorColor: Colors.red[300],
          ),
        );
      },
    );
  }

  static Future<T> actionBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    @required Widget primaryAction,
    @required ActionCallback onPrimaryActionTap,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            primaryAction: FlatButton(
              child: primaryAction,
              onPressed: onPrimaryActionTap == null
                  ? null
                  : () => onPrimaryActionTap(controller),
            ),
          ),
        );
      },
    );
  }

  static Future<T> simpleDialog<T>(
    BuildContext context, {
    String title,
    @required String message,
    Widget negativeAction,
    ActionCallback onNegativeActionTap,
    Widget positiveAction,
    ActionCallback positiveActionTap,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      builder: (_, controller) {
        return Flash.dialog(
          controller: controller,
          backgroundColor: _backgroundColor(context),
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: FlashBar(
            title:
                title == null ? null : Text(title, style: _titleStyle(context)),
            message: Text(message, style: _contentStyle(context)),
            actions: <Widget>[
              if (negativeAction != null)
                FlatButton(
                  child: negativeAction,
                  onPressed: onNegativeActionTap == null
                      ? null
                      : () => onNegativeActionTap(controller),
                ),
              if (positiveAction != null)
                FlatButton(
                  child: positiveAction,
                  onPressed: positiveActionTap == null
                      ? null
                      : () => positiveActionTap(controller),
                ),
            ],
          ),
        );
      },
    );
  }

  static Future<T> blockDialog<T>(
    BuildContext context, {
    @required Completer<T> dismissCompleter,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      onWillPop: () => Future.value(false),
      builder: (_, controller) {
        dismissCompleter.future.then((value) => controller.dismiss(value));
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      },
    );
  }
}

typedef ActionCallback = void Function(FlashController controller);

// class SaveFile {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//
//     return directory.path;
//   }
//
//   Future<Io.File> getImageFromNetwork(String url) async {
//     // var cacheManager = await CacheManager().getInstance();
//     Io.File file = await DefaultCacheManager().getSingleFile(url);
//     return file;
//   }
//
//   Future<Io.File> saveImage(String url) async {
//     // final file = await getImageFromNetwork(url);
//     final file = await downloadImage(url);
//     //retrieve local path for device
//     var path = await _localPath;
//     img.Image image = img.decodeImage(file);
//
//     // img.Image thumbnail = img.copyResize(image, 120);
//
//     // Save the thumbnail as a PNG.
//     return new Io.File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
//       ..writeAsBytesSync(img.encodePng(image));
//   }
//
//   Future<Uint8List> downloadImage(String _url) async {
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     File file = new File('$dir/${DateTime.now().toIso8601String()}');
//
//     if (file.existsSync()) {
//       var image = await file.readAsBytes();
//       return image;
//     } else {
//       var response = await http.get(
//         Uri.tryParse(_url),
//       );
//       var bytes = response.bodyBytes;
//       Uint8List newPng = await removeWhiteBackground(bytes);
//       file.writeAsBytes(newPng);
//       return newPng;
//     }
//   }
//
//   Future<Uint8List> removeWhiteBackground(Uint8List bytes) async {
//     img.Image image = img.decodeImage(bytes);
//     // img.Image transparentImage = await colorTransparent(image, 0, 0, 0);
//     var newPng = img.encodePng(image);
//     return newPng;
//   }
//
//   Future<img.Image> colorTransparent(
//       img.Image src, int red, int green, int blue) async {
//     var pixels = src.getBytes();
//     for (int i = 0, len = pixels.length; i < len; i += 4) {
//       if (pixels[i] == red && pixels[i + 1] == green && pixels[i + 2] == blue) {
//         pixels[i + 3] = 0;
//       }
//     }
//
//     return src;
//   }
// }
