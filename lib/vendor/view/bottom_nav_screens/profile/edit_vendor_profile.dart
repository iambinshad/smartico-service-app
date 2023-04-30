import 'package:flutter/material.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';

class VendorProfileEdit extends StatelessWidget {
  VendorProfileEdit({super.key, required userName,
    mobile,
    upiId,
    dob,
    gender,
    sKills,
    googledrive,
    linkedIn,
    github,
    about,
    currentAddress,
    country,
    state,
    city});

  final userName = TextEditingController();
  final mobile = TextEditingController();
  final upiId = TextEditingController();
  final dOB = TextEditingController();
  final gender = TextEditingController();
  final skills = TextEditingController();
  final googleDrive = TextEditingController();
  final linkedIn = TextEditingController();
  final gitHub = TextEditingController();
  final currentAddress = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
        ),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 6,
              width: double.infinity,
              child: const Center(
                child: CircleAvatar(
                  radius: 60,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  MyTextFormField(
                    controller: userName,
                    labelText: 'Username',
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: mobile,
                    labelText: 'Phone',
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: upiId,
                    labelText: 'UPI Id',
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: dOB,
                    labelText: 'DOB',
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: gender,
                    labelText: "Gender",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: skills,
                    labelText: "Skills",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: googleDrive,
                    labelText: "Google Drive",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: gitHub,
                    labelText: "GIt Hub",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: linkedIn,
                    labelText: "LinkedIn",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: currentAddress,
                    labelText: "Address",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: country,
                    labelText: "Coutry",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: state,
                    labelText: "State",
                  ),
                  kHeight10,
                  MyTextFormField(
                    controller: city,
                    labelText: "City",
                  ),
                  kHeight10,
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(width / 1.1, 45),
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      'UPDATE',
                      style: normalText.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
