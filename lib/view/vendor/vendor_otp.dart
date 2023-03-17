import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartico/view/user/roll_selecting.dart';

class VendorOtpScreen extends StatelessWidget {
   VendorOtpScreen({super.key});
  Widget kHeight15 = const SizedBox(height: 15,);
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
        //   elevation: 5.0,
        //   backgroundColor:  const Color.fromARGB(255, 121, 216, 206),
        //     title: const Text('SMARTICO',style: TextStyle(fontSize: 25),),
        //     centerTitle: true,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          const SizedBox(height: 180,),
          Card(
            elevation: 3.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 380,
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      kHeight40,
                      const Text('Verification Code',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 121, 216, 206))),
                      kHeight20,
                      const Text(
                          'Please enter the OTP number send on your\n                      registered Email Id ',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 81, 81, 81))),
                      kHeight30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 68,
                            width: 68,
                            child: TextField(
                              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if(value.isEmpty){
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: '0',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 123, 230, 219)),
                                  ),
                                  border: OutlineInputBorder(borderRadius :BorderRadius.all(Radius.circular(180.0)))),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            width: 68,
                            child: TextField(
                              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if(value.isEmpty){
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: '0',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 123, 230, 219)),
                                  ),
                                  border: OutlineInputBorder(borderRadius :BorderRadius.all(Radius.circular(180.0)))),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 68,
                            child: TextField(
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if(value.isEmpty){
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                
                                  hintText: '0',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 123, 230, 219)),
                                  ),
                                  
                                  border: OutlineInputBorder(borderRadius :BorderRadius.all(Radius.circular(180.0)))),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 68,
                            child: TextField(
                              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                 if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                                if(value.isEmpty){
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: '0',
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 123, 230, 219)),
                                  ),
                                  border: OutlineInputBorder(borderRadius :BorderRadius.all(Radius.circular(180.0)),)),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                      kHeight20,
                      ElevatedButton(
                        
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  RollSelectingScreen(),));
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5.0),
                          fixedSize: MaterialStateProperty.all(
                            const Size(185, 45),
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
                          'Verify',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        
                      
                      ),
                      kHeight15,
                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text(
                              "  Didn't Recieve the code?",
                              style: TextStyle(fontSize: 18),
                            ),
                            
                             TextButton(
      
                                child: const Text('Resend',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 83, 221, 207)),),
                                    onPressed: (){
                                      // Navigator.push(context,MaterialPageRoute(builder: (context) =>,));
      
                                    },
                              ),
                            
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}
