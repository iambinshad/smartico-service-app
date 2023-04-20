import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
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
                height: height / 5,
                child: Center(
                  child: Image(
                    image: const AssetImage(
                      'assets/splash/logo3.webp',
                    ),
                    height: height / 15,
                    width: width / 2,
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
                                  labelText: 'Email',
                                )),
                            kHeight20,
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Consumer<UserProvider>(
                                  builder: (context, value, child) =>
                                      MyTextFormField(
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
                                        labelText: 'Password',
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        obscureText:
                                            !value.userSignInPswdVisiblity,
                                      )),
                            ),
                            kHeight20,
                            kHeight10,
                            Consumer<CommonProvider>(
                              builder: (context, value, child) => value
                                      .clickLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
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
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              255, 123, 230, 219),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'sign in',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24),
                                      ),
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
    if (email == 'smarticoapp23@gmail.com') {
      log('You are Admin');
      Provider.of<CommonProvider>(context, listen: false).setClickLoading(true);

      Provider.of<AdminProvider>(context, listen: false)
          .checkAdminSignIn(context, email, password);

      Provider.of<CommonProvider>(context, listen: false)
          .setClickLoading(false);
    } else {
      Provider.of<CommonProvider>(context, listen: false).setClickLoading(true);
      log('You are someone else');
      Provider.of<UserProvider>(context, listen: false)
          .checkUserSignIn(context, password, email);
      Provider.of<CommonProvider>(context, listen: false)
          .setClickLoading(false);
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
