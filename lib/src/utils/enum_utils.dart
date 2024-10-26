import 'package:flutter/widgets.dart';
import 'package:local_fx/src/extensions/iterable_extensions.dart';

class TranslatedEnum<TEnum> {
  TranslatedEnum(
    this.enumValue,
    this.translation, {
    this.iconData,
  });

  final TEnum enumValue;
  final String translation;
  final IconData? iconData;
}

class EnumUtils {
  static List<TranslatedEnum<TEnum>> getTranslatedAndSortedEnum<TEnum>(
    List<TEnum> values,
    String Function(TEnum, int) itemText, {
    List<TEnum> exclude = const [],
    bool sort = true,
    IconData Function(TEnum, int)? iconData,
  }) {
    final filterValues = exclude.isNotEmpty
        ? values.where((el) => !exclude.contains(el))
        : values;
    final translatedValues = filterValues
        .mapIndex(
          (filter, index) => TranslatedEnum<TEnum>(
            filter,
            itemText(filter, index),
            iconData: iconData?.call(filter, index),
          ),
        )
        .toList();

    if (sort) {
      translatedValues.sort((x, y) => x.translation.compareTo(y.translation));
    }
    return translatedValues;
  }
}
