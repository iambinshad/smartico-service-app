import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';

import '../../../application/user/user_provider.dart';
import '../../../core/widgets.dart';

class UserSignUP extends StatelessWidget {
  UserSignUP({super.key});

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: height / 30,
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
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyTextFormField(
                                controller: fullNameController,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Full Name Required';
                                  }
                                  return null;
                                },
                                labelText: 'Full Name',
                              )),
                          kHeight20,
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyTextFormField(
                                controller: userNameController,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'User Name is Required';
                                  }
                                  return null;
                                },
                                labelText: 'User Name',
                              )),
                          kHeight20,
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyTextFormField(
                                controller: emailController,
                                validator: (p0) {
                                  var validatedEmail = emailValidation(p0);
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Email is required';
                                  } else if (validatedEmail == false) {
                                    return 'Enter Valid Email';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                labelText: 'Email',
                              )),
                          kHeight20,
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyTextFormField(
                                controller: phoneController,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Phone Number is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                labelText: 'Phone',
                              )),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                                builder: (context, value, child) =>
                                    MyTextFormField(
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
                                          color: Colors.blue,
                                          size: 23,
                                        ),
                                        onPressed: () {
                                          value.changeSignUpPswVisibleState(
                                              value.userSignUpPswdVisiblity);
                                        },
                                      ),
                                      obscureText:
                                          !value.userSignUpPswdVisiblity,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      labelText: 'Password',
                                      maxLines: 1,
                                    )),
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) =>
                                  MyTextFormField(
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Confirm Password is required';
                                  } else if (p0.length < 8) {
                                    return '8 characters required';
                                  } else if (confirmPasswordController.text !=
                                      passwordController.text) {
                                    return 'Not Match';
                                  }
                                  return null;
                                },
                                controller: confirmPasswordController,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    value.userSignUpConfPswdVisiblity
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.blue,
                                    size: 23,
                                  ),
                                  onPressed: () {
                                    value.changeSignUpConfPswVisibleState(
                                        value.userSignUpConfPswdVisiblity);
                                  },
                                ),
                                autocorrect: false,
                                enableSuggestions: false,
                                obscureText:!value.userSignUpConfPswdVisiblity,
                                labelText: 'Confirm Password',
                                maxLines: 1,
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
                          Consumer<CommonProvider>(
                              builder: (context, value, child) {
                            if (value.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return const SizedBox();
                          }),
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
    Provider.of<CommonProvider>(context, listen: false).loading = true;
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
    Provider.of<UserProvider>(context, listen: false).signUPNewUser(
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
