import 'package:flutter/material.dart';
import 'package:local_fx/src/features/common/presentation/colors.dart';
import 'package:local_fx/src/features/common/presentation/extensions/context_extensions.dart';

class Styles {
  Styles._();

  static const edgeInsetAll16 = EdgeInsets.all(16);
  static const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: 16);

  static const defaultBorderRadius = BorderRadius.all(Radius.circular(10));

  static const inputPadding =
  EdgeInsets.symmetric(horizontal: 12, vertical: 14);

  static const smallBorderRadius = BorderRadius.all(Radius.circular(12));

  static const formFieldBorder = OutlineInputBorder(
    borderRadius: smallBorderRadius,
    borderSide: BorderSide.none,
  );

  static OutlineInputBorder focusedFieldBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: smallBorderRadius,
      borderSide: BorderSide(color: context.colorScheme.primaryContainer),
    );
  }

  static OutlineInputBorder errorFieldBorder([
    double width = 1,
  ]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error, width: width),
      borderRadius: smallBorderRadius,
    );
  }

  static InputDecoration appInputDecoration(BuildContext context, {
    String? hint,
    String? errorText,
    String? counterText,
    Widget? suffix,
    Widget? prefix,
    bool? readOnly,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.grey1,
      border: formFieldBorder,
      enabledBorder: formFieldBorder,
      focusedBorder:
      (readOnly ?? false) ? formFieldBorder : focusedFieldBorder(context),
      counterText: counterText,
      focusedErrorBorder: errorFieldBorder(1.5),
      errorBorder: errorFieldBorder(),
      contentPadding: inputPadding,
      hintStyle: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.outlineVariant,
      ),
      errorMaxLines: 3,
      prefixIcon: prefix,
      hintText: hint,
      suffixIcon: suffix,
      errorText: errorText,
    );
  }
}
