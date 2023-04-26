import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/vendor/complete_signup/complete_signup_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/vendor/model/complete_sign_up/complete_sign_up.dart';

// ignore: must_be_immutable
class VendorApprovalSecondScrn extends StatelessWidget {
  VendorApprovalSecondScrn({super.key, this.imagePath});

  final cloudinary = CloudinaryPublic('dzeuipdky', 'ml_default', cache: false);

  File? imagePath;
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
                      hintText: '(optional)',
                      labelText: 'Skill'),
                  kHeight20,
                  MyTextFormField(
                      controller: prov.gitHub,
                      hintText: '(optional)',
                      labelText: 'GitHub'),
                  kHeight20,
                  MyTextFormField(
                      controller: prov.googleDrive,
                      hintText: '(optional)',
                      labelText: 'Google Drive'),
                  kHeight20,
                  MyTextFormField(
                      controller: prov.linkedIn,
                      hintText: '(optional)',
                      labelText: 'LinkedIn'),
                  kHeight30,
                  GestureDetector(
                    onTap: () {
                      submitClicked(context);
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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

  void submitClicked(context) async {
    log('click');
    final prov = Provider.of<CompleteSignUpProvider>(context, listen: false);
    final pin = int.parse(prov.pincode.text);
    final vendorAddressModel = VendorAddressModel(
        pincode: pin,
        country: prov.countryValue,
        currentAddress: prov.address.text,
        city: prov.cityValue,
        state: prov.stateValue);

    CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imagePath!.path,
            resourceType: CloudinaryResourceType.Image));
    final url = response.secureUrl;

    VendorSkillsModel vendorSkillsModel = VendorSkillsModel(
        skill: prov.skill.text,
        googleDrive: prov.googleDrive.text,
        linkedIn: prov.linkedIn.text,
        github: prov.gitHub.text,
        about: prov.about.text,
        profilePhoto: url);

    Provider.of<CompleteSignUpProvider>(context, listen: false)
        .setVendorProfile(vendorAddressModel, vendorSkillsModel, context);
  }
}
