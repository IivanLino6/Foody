import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryPickerWidget extends StatefulWidget {
  const CountryPickerWidget({Key? key}) : super(key: key);

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  CountryCode? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(

      //alignLeft: true,
      //flagWidth: 15,
      initialSelection: 'MX', // Optional, set initial selection
      onChanged: (countryCode) {
        setState(() {
          _selectedCountry = countryCode;
        });
      },
      // Other optional customizations (see documentation)
    );
  }
}