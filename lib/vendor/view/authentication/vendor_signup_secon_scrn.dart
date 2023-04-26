import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/complete_signup/complete_signup_provider.dart';
import 'package:smartico/core/constants.dart';
import '../../../application/user/user_provider.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import '../../../core/widgets.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class VendorSignUpScrnTwo extends StatelessWidget {
  VendorSignUpScrnTwo(
      {super.key,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.phoneNumber});

  final String fullName;
  final String userName;
  final String email;
  final String phoneNumber;
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  List<String> genderList = ['Male', 'Female', 'Others'];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CompleteSignUpProvider>(context,listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 100,
              child: Center(
                child: Image(
                  image: AssetImage(
                    'assets/splash/logo3.webp',
                  ),
                  height: 80,
                  width: 180,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                    elevation: 3.0,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          kHeight10,
                          const Text(
                            'Sign Up With Credetials',
                            style: TextStyle(
                                color: Color.fromARGB(255, 121, 216, 206),
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                          kHeight20,
                          Consumer<VendorProvider>(
                              builder: (context, value, child) {
                            List<DropdownMenuItem<Object>> genderListObject =
                                genderList
                                    .map((valueItem) => DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem)))
                                    .toList();
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: mainColor),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 8, right: 8),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    hint: const Text('Select Gender'),
                                    items: genderListObject,
                                    value: value.chooseGender,
                                    onChanged: (newValue) {
                                      value.dropdownvalue(newValue,1);
                                     prov.gender.text =
                                          newValue.toString();
                                      log(genderController.text);
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<VendorProvider>(
                              builder: (context, value, child) => MyTextFormField(controller: value.dateController,validator: (p0) {
                               
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Data of birth required';
                                  }
                                  return null;
                             
                              
                              },onTap: ()async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2101),
                                  );

                                  if (pickedDate != null) {
                                    value.dateController.text =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    log(value.dateController.text);
                                  }
                              },labelText: 'Date OF Birth',keyboardType: TextInputType.none,suffixIcon: const Icon(Icons.calendar_month_outlined,size: 25,),)
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) =>MyTextFormField(
                                        maxLines: 1,
                                        controller: passwordController,
                                        validator: (p0) {
                                          if (p0 == null || p0.isEmpty) {
                                            return 'Password is required';
                                          } else if (p0.length < 8) {
                                            return '8 characters required';
                                          }
                                          return null;
                                        },
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            value.userSignUpPswdVisiblity
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.blue,size: 22,
                                          ),
                                          onPressed: () {
                                            value.changeSignUpPswVisibleState(
                                                value.userSignUpPswdVisiblity);
                                          },
                                        ),
                                        labelText: 'Password',
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        obscureText:
                                            !value.userSignUpPswdVisiblity,
                                      )
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) => MyTextFormField(
                                        maxLines: 1,
                                        controller: confirmPasswordController,
                                        validator: (p0) {
                                         if (p0 == null || p0.isEmpty) {
                                    return 'Confirm Password is required';
                                  } else if (p0.length < 8) {
                                    return '8 characters required';
                                  } else if (p0 != passwordController.text) {
                                    return 'Not Match';
                                  }
                                  return null;
                                        },
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            value.userSignUpConfPswdVisiblity
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.blue,size: 22,
                                          ),
                                          onPressed: () {
                                            value.changeSignUpConfPswVisibleState(
                                          value.userSignUpConfPswdVisiblity);

                                          },
                                        ),
                                        labelText: 'Password',
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        obscureText:
                                            !value.userSignUpConfPswdVisiblity,
                                      )
                            ),
                          ),
                          kHeight15,
                          Center(
                            child: RichText(
                                text: const TextSpan(
                                    text:
                                        'By clicking agree & Sign Up, You are agreed\n  to the ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: 'Privacy Policy ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.blue)),
                                  TextSpan(
                                      text: 'and ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: 'User Agreement',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.blue)),
                                ])),
                          ),
                          kHeight15,
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                  
                                  signUpButtonClicked(context);
                                }
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                const Size(310, 50),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 123, 230, 219),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            
                              child: const Text(
                                'Agree & Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                             
                            
                          ),
                          kHeight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: 18),
                              ),
                              TextButton(
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 121, 216, 206)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            )
          ]),
        ),
      ),
    );
  }

  signUpButtonClicked(context) {
    log('inside signUpButton clicked');
    final gender = genderController.text.trim();
    final dob = dobController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    VendorProvider().signUpNewVendor(
      fullName: fullName,
      userName: userName,
      email: email,
      phone: phoneNumber,
      gender: gender,
      dob: dob,
      password: password,
      passwordConfirm: confirmPassword,
      context: context
    );
  }
}
