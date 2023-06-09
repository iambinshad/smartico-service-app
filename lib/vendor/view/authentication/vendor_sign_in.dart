import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/vendor_provider.dart';
import 'package:smartico/vendor/view/authentication/vendor_signup_firsrt_scrn.dart';
import '../../../application/user/user_provider.dart';
import '../../../core/widgets.dart';

class VendorSignIn extends StatelessWidget {
  VendorSignIn({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: height / 6,
                child: const Center(
                  child: Image(
                    image: AssetImage(
                      'assets/splash/newLogo.png',
                    ),
                    height: 70,
                    width: 200,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                      elevation: 1.0,
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
                                fontSize: 20, fontWeight: FontWeight.w500),
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
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  size: 24,
                                ),
                                labelText: 'Email',
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
                                          value.userSignInPswdVisiblity
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.blue,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          value.changeSignInVisibleState(
                                              value.userSignInPswdVisiblity);
                                        },
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        size: 24,
                                      ),
                                      maxLines: 1,
                                      labelText: 'Password',
                                      obscureText:
                                          !value.userSignInPswdVisiblity,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                    )),
                          ),
                          kHeight20,
                          kHeight10,
                          context.watch<VendorProvider>().isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                          kHeight20,
                          
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
                                        builder: (context) =>
                                            VendorSignUPScrnOne(),
                                      ));
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> signInClicked(context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    Provider.of<VendorProvider>(context, listen: false)
        .checkVendorSignIn(context, email, password);
  }

  bool emailValidation(value) {
    bool emailResult = EmailValidator.validate(value);
    return emailResult;
  }
}
