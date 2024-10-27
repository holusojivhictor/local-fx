import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_fx/src/features/common/presentation/styles.dart';

enum ToastType {
  info,
  succeed,
  warning,
  error,
}

class ToastUtils {
  static Duration toastDuration = const Duration(seconds: 3);

  static FToast of(BuildContext context) {
    final fToast = FToast().init(context);
    return fToast;
  }

  static void showSucceedToast(
    FToast toast,
    String msg, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Widget? trailing,
    VoidCallback? onTap,
  }) =>
      _showToast(
        toast,
        msg: msg,
        textColor: Colors.white,
        type: ToastType.succeed,
        gravity: gravity,
        trailing: trailing,
        onTap: onTap,
      );

  static void showInfoToast(
    FToast toast,
    String msg, {
    VoidCallback? action,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration? autoCloseDuration,
  }) =>
      _showToast(
        toast,
        msg: msg,
        textColor: Colors.white,
        autoCloseDuration: autoCloseDuration,
        gravity: gravity,
      );

  static void showWarningToast(
    FToast toast,
    String msg, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration? autoCloseDuration,
  }) =>
      _showToast(
        toast,
        msg: msg,
        textColor: Colors.white,
        type: ToastType.warning,
        autoCloseDuration: autoCloseDuration,
        gravity: gravity,
      );

  static void showErrorToast(
    FToast toast,
    String msg, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) =>
      _showToast(
        toast,
        msg: msg,
        textColor: Colors.white,
        type: ToastType.error,
        gravity: gravity,
      );

  static void showCustomToast(
    FToast toast,
    Widget child, {
    ToastGravity gravity = ToastGravity.CENTER,
  }) =>
      _showToast(
        toast,
        custom: child,
        gravity: gravity,
      );

  static void _showToast(
    FToast toast, {
    String msg = '',
    Color textColor = Colors.blue,
    ToastType type = ToastType.info,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Widget? custom,
    Widget? trailing,
    VoidCallback? onTap,
    Duration? autoCloseDuration,
  }) {
    Color bgColor;
    Icon? icon;
    switch (type) {
      case ToastType.info:
        bgColor = Colors.blue;
        icon = const Icon(Icons.info, color: Colors.white);
      case ToastType.succeed:
        bgColor = Colors.green;
        icon = const Icon(Icons.check, color: Colors.white);
      case ToastType.warning:
        bgColor = Colors.orange;
        icon = const Icon(Icons.warning, color: Colors.white);
      case ToastType.error:
        bgColor = Colors.red;
    }

    final widget = buildToast(
      msg,
      textColor,
      bgColor,
      toast.context,
      icon: icon,
      trailing: trailing,
      onTap: () {
        onTap?.call();
        toast.removeCustomToast();
      },
    );

    toast.showToast(
      child: custom ?? widget,
      gravity: gravity,
      toastDuration: autoCloseDuration ?? toastDuration,
    );
  }

  static Widget buildToast(
    String msg,
    Color textColor,
    Color bgColor,
    BuildContext? context, {
    Icon? icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Styles.edgeInsetAll16,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: Styles.defaultBorderRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                msg,
                style: TextStyle(color: textColor),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 10),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}
