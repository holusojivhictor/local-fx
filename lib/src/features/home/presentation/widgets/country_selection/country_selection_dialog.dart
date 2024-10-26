import 'package:flutter/material.dart';
import 'package:local_fx/src/extensions/string_extensions.dart';
import 'package:local_fx/src/features/common/domain/models/country/country.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';

extension CountryExtensions on List<Country> {
  List<Country> stringSearch(String str) {
    var search = str;
    search = search.toLowerCase().noDiacritics;
    return where(
      (country) =>
          country.name.replaceAll('+', '').toLowerCase().noDiacritics
              .contains(search) ||
          country.nameTranslations.values.any(
            (element) => element.toLowerCase().noDiacritics.contains(search),
          ) ||
          country.currencyCode.toLowerCase().noDiacritics.contains(search),
    ).toList();
  }
}

class SelectionDialogStyle {
  SelectionDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });

  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;
}

class CountrySelectionDialog extends StatefulWidget {
  const CountrySelectionDialog({
    required this.languageCode,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    super.key,
    this.style,
  });

  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final List<Country> filteredCountries;
  final SelectionDialogStyle? style;
  final String languageCode;

  @override
  State<CountrySelectionDialog> createState() => _CountrySelectionDialogState();
}

class _CountrySelectionDialogState extends State<CountrySelectionDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries.toList()
      ..sort(
        (a, b) => a
            .localizedName(widget.languageCode)
            .compareTo(b.localizedName(widget.languageCode)),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    const defaultHorizontalPadding = 40.0;
    const defaultVerticalPadding = 24.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        vertical: defaultVerticalPadding,
        horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
            ? (mediaWidth - width) / 2
            : defaultHorizontalPadding,
      ),
      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.style?.searchFieldPadding ?? EdgeInsets.zero,
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      labelText: S.of(context).searchCountry,
                    ),
                onChanged: (value) {
                  _filteredCountries = widget.countryList.stringSearch(value)
                    ..sort(
                      (a, b) => a
                          .localizedName(widget.languageCode)
                          .compareTo(b.localizedName(widget.languageCode)),
                    );
                  if (mounted) setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: Text(
                        _filteredCountries[index].flag,
                        style: const TextStyle(fontSize: 18),
                      ),
                      contentPadding: widget.style?.listTilePadding,
                      title: Text(
                        _filteredCountries[index]
                            .localizedName(widget.languageCode),
                        style: widget.style?.countryNameStyle ??
                            const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        _filteredCountries[index].currencyCode,
                        style: widget.style?.countryCodeStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop();
                      },
                    ),
                    widget.style?.listTileDivider ??
                        const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
