
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/complete_signup/complete_signup_provider.dart';

import 'constants.dart';

Widget kHeight10 = const SizedBox(
  height: 10,
);
Widget kHeight15 = const SizedBox(
  height: 15,
);
Widget kHeight20 = const SizedBox(
  height: 20,
);
Widget kHeight30 = const SizedBox(
  height: 30,
);
Widget kHeight40 = const SizedBox(
  height: 40,
);
Widget kWidth10 = const SizedBox(
  width: 10,
);
Widget kWidth20 = const SizedBox(
  width: 20,
);
Widget kWidth30 = const SizedBox(
  width: 30,
);
Widget kWidth40 = const SizedBox(
  width: 40,
);

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.validator,
    this.maxLines,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon ;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:maxLines ,
      keyboardType: keyboardType,
      controller: controller,
      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 123, 230, 219))),
        hintText: hintText,
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 111, 111, 111),
        ),
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
   TextFieldName({super.key, required this.value});
  String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            value,
            style: normalText,
          ),
        ],
      ),
    );
  }
}


Consumer cscPicker() {
  return Consumer<CompleteSignUpProvider>(
    builder: (context, conValue, child) => CSCPicker(
      
      showStates: true,    
      
      showCities: true,
      flagState: CountryFlag.DISABLE,

      dropdownDecoration: BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1)),

      disabledDropdownDecoration: BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300, width: 1)),

      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",

      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",

      countryFilter: const [
        CscCountry.India,
        CscCountry.United_States,
        CscCountry.Canada
      ],

      selectedItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),

      dropdownHeadingStyle:const TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

      dropdownItemStyle:const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),

      dropdownDialogRadius: 10.0,

      searchBarRadius: 10.0,

      onCountryChanged: (value) {
        conValue.setCountryValue(value);
      },

      onStateChanged: (value) {
        conValue.setStateValue(value);
      },

      onCityChanged: (value) {
        conValue.setCityValue(value);
      },
    ),
  );
}
