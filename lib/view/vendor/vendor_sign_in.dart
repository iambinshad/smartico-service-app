import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/view/vendor/vendor_signup_firsrt_scrn.dart';


import '../../application/user/user_provider.dart';
import '../user/user_sign_up.dart';

class VendorSignIn extends StatelessWidget {
   VendorSignIn({super.key});
  
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Widget kHeight10 = const SizedBox(height: 10,);
Widget KHeight15 = const SizedBox(height: 15,);
Widget kHeight20 = const SizedBox(height: 20,);
Widget kHeight30 = const SizedBox(height: 30,);
Widget kHeight40 = const SizedBox(height: 40,);
Widget kWidth10 = const SizedBox(width: 10,);
Widget kWidth20 = const SizedBox(width: 20,);
Widget kWidth30 = const SizedBox(width: 30,);
Widget kWidth40 = const SizedBox(width: 40,);
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor:  const Color.fromARGB(255, 121, 216, 206),
        //   title: const Text('SMARTICO',style: TextStyle(fontSize: 25),),
        //   centerTitle: true,
        // ),
        resizeToAvoidBottomInset: false,
        // backgroundColor: const Color.fromARGB(255, 181, 177, 177),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
            const SizedBox(
                height: 160,
                child: Center(child: Image(image: AssetImage('assets/splash/logo3.webp',),height: 100,width: 230,),),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 3.0,
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
                            
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
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
                        child: Consumer<UserProvider>(
                          builder:(context, value, child) => 
                           TextFormField(
                            style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                            controller: passwordController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty 
                                 ) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return '8 characters required';
                              } 
                              return null;
                            },
                            decoration: InputDecoration(
                               filled: true,
                            fillColor:Colors.white ,
                              suffixIcon:IconButton(icon: Icon(value.userSignInPswdVisiblity?Icons.visibility:Icons.visibility_off,color: Colors.blue,),onPressed: (){
                            value.changeSignInVisibleState(value.userSignInPswdVisiblity);
                              },),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 123, 230, 219))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                        
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
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      ),
                      kHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(right: 18, left: 18),
                            child: Divider(
                              thickness: 1,
                              color: Colors.black,
                              height: 5,
                            ),
                          )),
                          Text(
                            'Or',
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(right: 22, left: 22),
                            child: Divider(
                              thickness: 1,
                              color: Colors.black,
                              height: 5,
                            ),
                          )),
                        ],
                      ),
                      kHeight10,
                      Container(
                        width: 315,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children:  [
                            kWidth10,
                            const Center(
                                child: Image(
                              image: AssetImage(
                                  'assets/authentication/google-logo-9808.png'),
                              height: 35.0,
                              width: 35.0,
                            )),
                            kWidth20,
                            const Text(
                              'Continue With Google',
                              style: TextStyle(fontSize: 22,fontFamily: 'Roboto',fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      kHeight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          
                           TextButton(
    
                              child: const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 121, 216, 206)),),
                                  onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => VendorSignUPScrnOne(),));
    
                                  },
                            ),
                          
                        ],
                      ),
                       const TextButton(
                        onPressed: null,
                        child: Text('Forgot Password',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 121, 216, 206))),
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

    if (email.isEmpty || password.isEmpty) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserSignUP(),
        ));
  }

  bool emailValidation(value) {
    bool emailResult = EmailValidator.validate(value);
    return emailResult;
  }
}