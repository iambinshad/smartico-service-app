 import 'package:flutter/material.dart';

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
    super.key, this.validator,required this.hintText,required this.labelText, required this.controller, this.keyboardType =TextInputType.text,
  });
final String? Function(String?)? validator;
final String? hintText;
final String? labelText;
final TextEditingController? controller;
final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:keyboardType,
      controller:controller ,
       style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
        
      validator: validator,
      decoration: InputDecoration(
         filled: true,
        fillColor:Colors.white ,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 123, 230, 219))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 111, 111, 111),
        ),
      ),
    );
  }
}
