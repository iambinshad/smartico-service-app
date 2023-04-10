import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/complete_signup/complete_signup_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/model/complete_sign_up/complete_sign_up.dart';

class VendorApprovalSecondScrn extends StatelessWidget {
   VendorApprovalSecondScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final prov = context.read<CompleteSignUpProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text(
          'Professional Details',
        ),
      ),
      body: Center(
        child: Card(
          child: SizedBox(
            width: width / 1.1,
            height: height / 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MyTextFormField(
                      controller: prov.skill,
                      hintText: 'Enter skills',
                      labelText: 'Skill'),
                  kHeight20,
                  MyTextFormField(
                      controller: prov.gitHub,
                      hintText: 'Enter GitHub Link',
                      labelText: 'GitHub'),
                  kHeight20,
                  MyTextFormField(
                      controller: prov.gitHub,
                      hintText: 'Enter Google Drive Link',
                      labelText: 'Google Drive'),
                  kHeight20,
                  MyTextFormField(
                      controller: prov.gitHub,
                      hintText: 'Enter LinkedIn Link',
                      labelText: 'LinkedIn'),
                  kHeight30,
                  GestureDetector(
                    onTap: () {
                      SubmitClicked(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 123, 230, 219),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: width / 1.11,
                      child: const Center(
                          child: Text(
                        'Submit',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void SubmitClicked(context) {
final prov =Provider.of<CompleteSignUpProvider>(context,listen: false);
    // final vendorProfileModelData = CompleteSignUpModel(fullName:prov.fullName.text,  email:prov.email.text.trim(), address:prov.address[], about: about, profilePhoto: profilePhoto, phone: phone)

  }
}
