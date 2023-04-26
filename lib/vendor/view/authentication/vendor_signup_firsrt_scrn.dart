import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/complete_signup/complete_signup_provider.dart';
import 'package:smartico/vendor/view/authentication/vendor_signup_secon_scrn.dart';

import '../../../core/widgets.dart';

class VendorSignUPScrnOne extends StatelessWidget {
  VendorSignUPScrnOne({super.key});

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final prov = context.read<CompleteSignUpProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const SizedBox(
              height: 110,
              child: Center(
                child: Image(
                  image: AssetImage(
                    'assets/splash/logo3.webp',
                  ),
                  height: 100,
                  width: 250,
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
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyTextFormField(
                                controller: prov.fullName,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Full Name Required';
                                  }
                                  return null;
                                },
                              labelText: 'Full Name',),),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: MyTextFormField(controller: userNameController,validator: (p0) {
                              if(p0 == null || p0.isEmpty){
                                return 'Username Is Required';
                              }
                              return null;
                            },labelText:'Username',)
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: MyTextFormField(controller: prov.email,validator: (p0) {
                                var validatedEmail = emailValidation(p0);
                                if (p0 == null || p0.isEmpty) {
                                  return 'Email is required';
                                } else if (validatedEmail == false) {
                                  return 'Enter Valid Email';
                                }
                                return null;
                            },keyboardType: TextInputType.emailAddress,labelText: 'Email',)
                          ),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: MyTextFormField(controller: prov.mobile,validator: (p0) {
                               if (p0 == null || p0.isEmpty) {
                                  return 'Phone Number Required';
                                } else if (p0.length > 10) {
                                  return 'Enter Valid Phone Number';
                                }
                                return null;
                            },keyboardType: TextInputType.phone,labelText: 'Phone',),
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
                              'Proceed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
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

  signUpButtonClicked(context)async {
   
    final fullName = Provider.of<CompleteSignUpProvider>(context, listen: false)
        .fullName
        .text;
    final userName = userNameController.text;
    final email = Provider.of<CompleteSignUpProvider>(context, listen: false)
        .email
        .text
        .trim();
    final phoneNumber =
        Provider.of<CompleteSignUpProvider>(context, listen: false).mobile.text;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VendorSignUpScrnTwo(
            fullName: fullName,
            userName: userName,
            email: email,
            phoneNumber: phoneNumber)));
  }
}
