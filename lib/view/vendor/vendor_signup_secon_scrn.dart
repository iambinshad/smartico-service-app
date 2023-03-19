import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/view/vendor/vendor_otp.dart';

import '../../application/user/user_provider.dart';
import '../user/user_otp.dart';
import 'package:intl/intl.dart';

class VendorSignUpScrnTwo extends StatelessWidget {
  VendorSignUpScrnTwo({super.key});

  final genderController = TextEditingController();
  final dobController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  List<String> genderList = ['Male', 'Female', 'Transgender'];

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
                height: 160,
                child: Center(child: Image(image: AssetImage('assets/splash/logo3.webp',),height: 100,width: 250,),),
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

                          // Padding(
                          //   padding: const EdgeInsets.only(right: 20, left: 20),
                          //   child: TextFormField(
                          //                                 style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),

                          //     controller: genderController,
                          //     validator: (value) {

                          //       if (value == null || value.isEmpty) {
                          //         return 'Gender is required';
                          //       }
                          //       return null;
                          //     },
                          //     decoration: InputDecoration(
                          //        filled: true,
                          //       fillColor:Colors.white ,
                          //       focusedBorder: const OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Color.fromARGB(255, 123, 230, 219))),
                          //       enabledBorder: const OutlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.black)),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       hintText: 'Select Gender',
                          //       labelText: 'Gender',
                          //       hintStyle: const TextStyle(
                          //         color: Color.fromARGB(255, 111, 111, 111),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Consumer<UserProvider>(
                              builder: (context, value, child) =>
                                  Consumer<UserProvider>(
                                      builder: (context, value, child) {
                                    List<DropdownMenuItem<Object>>
                                        genderListObject = genderList
                                            .map((valueItem) =>
                                                DropdownMenuItem(
                                                    value: valueItem,
                                                    child: Text(valueItem)))
                                            .toList();
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 8, right: 8),
                                          child: DropdownButton(
                                            underline: const SizedBox(),
                                            isExpanded: true,
                                            hint: const Text('Select Gender'),
                                            items: genderListObject,
                                            value: value.choosedGender,
                                            onChanged: (newValue) {
                                              value.dropdownvalue(newValue);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) => TextFormField(
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                keyboardType:TextInputType.none,
                                controller: value.dateController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Data of birth required';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );

                                  if (pickedDate != null) {
                                    value.dateController.text =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.calendar_month),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 123, 230, 219))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Select Date of birth',
                                  labelText: 'DOB',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 111, 111, 111),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) => TextFormField(
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 8) {
                                    return '8 characters required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value.userSignUpPswdVisiblity
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      value.changeSignUpPswVisibleState(
                                          value.userSignUpPswdVisiblity);
                                    },
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 123, 230, 219))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter Your Password',
                                  labelText: 'Password',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 111, 111, 111),
                                  ),
                                ),
                                obscureText: !value.userSignUpPswdVisiblity,
                                enableSuggestions: false,
                                autocorrect: false,
                              ),
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) => TextFormField(
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                controller: confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm Password is required';
                                  } else if (value.length < 8) {
                                    return '8 characters required';
                                  } else if (value != passwordController) {
                                    return 'Not Match';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value.userSignUpConfPswdVisiblity
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      value.changeSignUpConfPswVisibleState(
                                          value.userSignUpConfPswdVisiblity);
                                    },
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 123, 230, 219))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 111, 111, 111),
                                  ),
                                ),
                                obscureText: !value.userSignUpConfPswdVisiblity,
                                enableSuggestions: false,
                                autocorrect: false,
                              ),
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
                            onPressed: () {},
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
                            child: TextButton(
                              child: const Text(
                                'Agree & Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   signUpButtonClicked(context);
                                // }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VendorOtpScreen(),
                                    ));
                              },
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
    final email = genderController.text.trim();
    final phoneNumber = dobController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserOtpScreen(),
    ));
  }
}
