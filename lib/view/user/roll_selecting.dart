import 'package:flutter/material.dart';

import '../../core/widgets.dart';
import '../vendor/vendor_sign_in.dart';

class RollSelectingScreen extends StatelessWidget {
  RollSelectingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Select A Role',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'ROBOTO',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 123, 230, 219),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 4.0,
                      child: Column(children: [
                        kHeight40,
                        kHeight10,
                        const Text(
                          'Looking For A Specialist',
                          style: TextStyle(
                              fontSize: 35,
                              color: Color.fromARGB(255, 123, 230, 219),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                        kHeight40,
                        const Center(
                          child: Text(
                            'To place any type of order to',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Text(
                          'search for a performer',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        kHeight40,
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const RollSelectingScreen(),));
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5.0),
                            fixedSize: MaterialStateProperty.all(
                              const Size(280, 45),
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
                            'I Need Service',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                // Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: const [
                //           Expanded(
                //               child: Padding(
                //             padding: EdgeInsets.only(right: 18, left: 18),
                //             child: Divider(
                //               thickness: 2,
                //               color: Colors.black,
                //               height: 5,
                //             ),
                //           )),
                //           Text(
                //             'Or',
                //             style: TextStyle(fontSize: 20),
                //           ),
                //           Expanded(
                //               child: Padding(
                //             padding: EdgeInsets.only(right: 22, left: 22),
                //             child: Divider(
                //               thickness: 2,
                //               color: Colors.black,
                //               height: 5,
                //             ),
                //           )),
                //         ],
                //       ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 4.0,
                      child: Column(
                        children: [
                          kHeight40,
                          kHeight10,
                          const Text(
                            'I Want To Find A Job',
                            style: TextStyle(
                                fontSize: 35,
                                color: Color.fromARGB(255, 123, 230, 219),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                          kHeight40,
                          const Center(
                            child: Text(
                              'Search And Execute Orders In',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Text(
                            'your field of activity',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          kHeight40,
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VendorSignIn(),
                                  ));
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5.0),
                              fixedSize: MaterialStateProperty.all(
                                const Size(280, 45),
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
                              'I Need Job',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
