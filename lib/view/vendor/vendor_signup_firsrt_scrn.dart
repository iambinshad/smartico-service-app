import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:smartico/view/vendor/vendor_signup_secon_scrn.dart';

import '../user/user_otp.dart';


class VendorSignUPScrnOne extends StatelessWidget {
  VendorSignUPScrnOne({super.key});

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Widget kHeight10 = const SizedBox(height: 10,);
Widget KHeight15 = const SizedBox(height: 15,);
Widget kHeight20 = const SizedBox(height: 20,);
Widget kHeight30 = const SizedBox(height: 30,);
Widget kHeight40 = const SizedBox(height: 40,);
Widget kWidth10 = const SizedBox(width: 10,);
Widget kWidth20 = const SizedBox(width: 20,);
Widget kWidth30 = const SizedBox(width: 30,);
Widget kWidth40 = const SizedBox(width: 40,);


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
                           style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),

                          controller: fullNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full Name Required';
                            }
                            return null;
                          },
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
                                                      style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),

                          controller: userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User Name Required';
                            }
                            return null;
                          },
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
                                                      style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),

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
                            fillColor:Colors.white ,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 123, 230, 219))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
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
                                                      style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),

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
                            fillColor:Colors.white ,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 123, 230, 219))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
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
                     
                     
                      KHeight15,
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VendorSignUPScrnTwo(),));
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
                        child: TextButton(
                          child: const Text(
                            'Proceed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   signUpButtonClicked(context);
                            // }
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  VendorSignUPScrnTwo(),));
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
                                  color: Color.fromARGB(255, 121, 216, 206)),
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
    final fullName = fullNameController.text.trim();
    final userName = userNameController.text.trim();
    final email = emailController.text.trim();
    final phoneNumber = phoneController.text.trim();


    if (fullName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty 
       ) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  UserOtpScreen(),
    ));
  }
}
