import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/admin/admin_provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/core/theme/theme.dart';
import 'package:smartico/user/view/authentication/user_sign_up.dart';
import '../../../application/user/user_provider.dart';
import '../../../core/widgets.dart';

class UserSignIn extends StatelessWidget {
  UserSignIn({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        
        resizeToAvoidBottomInset: false,
       
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              

               SizedBox(
                height: height/5,
                child: Center(
                  child: Image(
                    image:const AssetImage(
                      'assets/splash/logo3.webp',
                    ),
                    height:height/15 ,
                    width: width/2,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Card(
                        elevation: 6.0,
                        child: Column(
                          children: [
                            kHeight10,
                            const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 121, 216, 206),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            kHeight20,
                            const Text(
                              'Enter Your Email And Password',
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
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
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                      borderSide:const BorderSide(
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
                                        value.userSignInPswdVisiblity
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        value.changeSignInVisibleState(
                                            value.userSignInPswdVisiblity);
                                      },
                                    ),
                                    focusedBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                        borderSide:const BorderSide(
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
                                  obscureText: !value.userSignInPswdVisiblity,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                ),
                              ),
                            ),
                            kHeight20,
                            kHeight10,
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  log('email and password validated');
                                  signInClicked(context);
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
                                'sign in',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 24),
                              ),
                            ),
                            kHeight10,
                            Consumer<CommonProvider>(
                builder: (context, value, child){
                  if(value.loading){
                    return const Center( child: CircularProgressIndicator(),);
      }
                  return const SizedBox();
                  }),
                  kHeight10,
                            // Row(j
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: const [
                            //     Expanded(
                            //         child: Padding(
                            //       padding: EdgeInsets.only(right: 18, left: 18),
                            //       child: Divider(
                            //         thickness: 1,
                            //         color: Colors.black,
                            //         height: 5,
                            //       ),
                            //     )),
                            //     Text(
                            //       'Or',
                            //       style: TextStyle(fontSize: 20),
                            //     ),
                            //     Expanded(
                            //         child: Padding(
                            //       padding: EdgeInsets.only(right: 22, left: 22),
                            //       child: Divider(
                            //         thickness: 1,
                            //         color: Colors.black,
                            //         height: 5,
                            //       ),
                            //     )),
                            //   ],
                            // ),
                            // kHeight10,
                            // Container(
                            //   width: 315,
                            //   height: 55,
                            //   decoration: BoxDecoration(
                            //       border: Border.all(),
                            //       borderRadius: BorderRadius.circular(8)),
                            //   child: Row(
                            //     children: [
                            //       kWidth10,
                            //       const Center(
                            //           child: Image(
                            //         image: AssetImage(
                            //             'assets/authentication/google-logo-9808.png'),
                            //         height: 35.0,
                            //         width: 35.0,
                            //       )),
                            //       kWidth20,
                            //       const Text(
                            //         'Continue With Google',
                            //         style: TextStyle(
                            //             fontSize: 22,
                            //             fontFamily: 'Roboto',
                            //             fontWeight: FontWeight.bold),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            kHeight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextButton(
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 121, 216, 206)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserSignUP(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                            
                          ],
                        )),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> signInClicked(BuildContext context) async {
 
    log('signin clicked');
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      return;
    }
    
    if(email == 'smarticoapp23@gmail.com'){
      log('You are Admin');
      Provider.of<CommonProvider>(context,listen: false).onloading();

      Provider.of<AdminProvider>(context,listen: false).checkAdminSignIn(context, email, password);
    }else{
      Provider.of<CommonProvider>(context,listen: false).onloading();
      log('You are someone else');
      Provider.of<UserProvider>(context, listen: false)
        .checkUserSignIn(context, password, email);
    }
  }

  bool emailValidation(value) {
    bool emailResult = EmailValidator.validate(value);
    return emailResult;
  }

  disposeTextFiled() {
    emailController.clear();
    passwordController.clear();
  }
}
