import 'package:flutter/material.dart';
import 'package:local_fx/src/utils/enum_utils.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    required this.hint,
    required this.currentValue,
    required this.values,
    super.key,
    this.onChanged,
    this.isExpanded = true,
    this.withoutUnderline = true,
  });

  final String hint;
  final T currentValue;
  final List<TranslatedEnum<T>> values;
  final void Function(T, BuildContext)? onChanged;
  final bool isExpanded;
  final bool withoutUnderline;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: isExpanded,
      hint: Text(hint),
      value: currentValue,
      underline: withoutUnderline
          ? Container(height: 0, color: Colors.transparent)
          : null,
      onChanged: onChanged != null ? (v) => onChanged!(v as T, context) : null,
      selectedItemBuilder: (context) => values
          .map(
            (lang) => Align(
              alignment: Alignment.centerLeft,
              child: Text(lang.translation, textAlign: TextAlign.center),
            ),
          ).toList(),
      items: values
          .map<DropdownMenuItem<T>>(
            (lang) => DropdownMenuItem<T>(
              value: lang.enumValue,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: lang.enumValue != currentValue
                        ? const SizedBox(width: 20)
                        : const Center(child: Icon(Icons.check)),
                  ),
                  Expanded(
                    child: Text(
                      lang.translation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
    );
  }
}
