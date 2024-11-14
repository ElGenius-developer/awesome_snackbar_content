part of '../awesome_snackbar_content.dart';

/// to handle failure, success, help and warning `ContentType` class is being used/// to handle failure, success, help and warning `ContentType` class is being used
class SnackBarContentType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  const SnackBarContentType(this.message, [this.color]);

  static const SnackBarContentType help = SnackBarContentType('help', DefaultColors.helpBlue);
  static const SnackBarContentType failure = SnackBarContentType('failure', DefaultColors.failureRed);
  static const SnackBarContentType success = SnackBarContentType('success', DefaultColors.successGreen);
  static const SnackBarContentType warning = SnackBarContentType('warning', DefaultColors.warningYellow);
}
