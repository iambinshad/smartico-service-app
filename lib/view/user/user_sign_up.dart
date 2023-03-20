import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/core/theme/theme.dart';
import 'package:smartico/view/user/user_otp.dart';

import '../../application/user/user_provider.dart';

class UserSignUP extends StatelessWidget {
  UserSignUP({super.key});

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              height: 40,
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
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              controller: fullNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Full Name Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Enter Full Name',
                                labelText: 'Full Name',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              controller: userNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'User Name Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Enter Username',
                                labelText: 'Username',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              controller: emailController,
                              validator: (value) {
                                var validatedEmail = emailValidation(value);
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (validatedEmail == false) {
                                  return 'Enter Valid Email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Enter Your Email',
                                labelText: 'Email',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 111, 111, 111),
                                ),
                              ),
                            ),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone Number Required';
                                } else if (value.length > 10) {
                                  return 'Enter Valid Phone Number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Enter Phone Number',
                                labelText: 'Phone Number',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 111, 111, 111),
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
                                  } 
                                  // else if (confirmPasswordController !=
                                  //     passwordController) {
                                  //   return 'Not Match';
                                  // }
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
                                if (_formKey.currentState!.validate()) {
                                  log('inside validate');
                                  signUpButtonClicked(context);
                                }
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

  bool emailValidation(String? value) {
    bool emailResult = EmailValidator.validate(value.toString());
    return emailResult;
  }

  signUpButtonClicked(context) {
    log('inside signUpbuttonClicked');
    final fullName = fullNameController.text.trim();
    final userName = userNameController.text.trim();
    final email = emailController.text.trim();
    final phoneNumber = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return;
    }                                           
    Provider.of<UserProvider>(context,listen: false).signUPNewUser(
      fullName: fullName,
      userName: userName,
      email: email,
      phone: phoneNumber,
      password: password,
      conformPassword: confirmPassword,
      context: context,
    );
  }
}
