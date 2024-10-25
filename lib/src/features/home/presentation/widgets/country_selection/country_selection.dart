import 'package:flutter/material.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/country/country.dart';
import 'package:local_fx/src/features/home/presentation/widgets/country_selection/country_selection_dialog.dart';

class CountrySelection extends StatefulWidget {
  const CountrySelection({
    this.languageCode = 'en',
    this.dropdownDecoration = const BoxDecoration(),
    this.dropdownIconPosition = IconPosition.leading,
    this.enabled = true,
    this.showDropdownIcon = true,
    super.key,
    this.initialCountryCode,
    this.countries,
    this.onCountryChanged,
    this.selectionDialogStyle,
    this.dropdownTextStyle,
  });

  final String languageCode;
  final String? initialCountryCode;
  final List<Country>? countries;
  final ValueChanged<Country>? onCountryChanged;
  final SelectionDialogStyle? selectionDialogStyle;
  final TextStyle? dropdownTextStyle;
  final BoxDecoration dropdownDecoration;
  final IconPosition dropdownIconPosition;
  final bool enabled;
  final bool showDropdownIcon;

  @override
  State<CountrySelection> createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;

  @override
  void initState() {
    super.initState();

    _countryList = widget.countries ?? countries;
    filteredCountries = _countryList;

    _selectedCountry = _countryList.firstWhere(
      (item) => item.isoCode == (widget.initialCountryCode ?? 'US'),
      orElse: () => _countryList.first,
    );
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountrySelectionDialog(
          languageCode: widget.languageCode.toLowerCase(),
          style: widget.selectionDialogStyle,
          filteredCountries: filteredCountries,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: widget.dropdownDecoration,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
        onTap: widget.enabled ? _changeCountry : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 8),
            if (widget.enabled &&
                widget.showDropdownIcon &&
                widget.dropdownIconPosition == IconPosition.leading) ...[
              const Icon(Icons.arrow_drop_down),
              const SizedBox(width: 4),
            ],
            Text(
              _selectedCountry.flag,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 6),
            FittedBox(
              child: Text(
                _selectedCountry.currencyCode,
                style: widget.dropdownTextStyle,
              ),
            ),
            if (widget.enabled &&
                widget.showDropdownIcon &&
                widget.dropdownIconPosition == IconPosition.trailing) ...[
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down),
            ],
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}
