import 'package:flutter/material.dart';
import 'package:smartico/vendor/controller/complete_sign_up/complete_sign_up.dart';
import 'package:smartico/vendor/model/complete_sign_up/complete_sign_up.dart';
import 'package:smartico/vendor/view/bottom_nav/vendor_bottom_nav.dart';

class CompleteSignUpProvider with ChangeNotifier {
  dynamic countryValue;
  dynamic stateValue;
  dynamic cityValue;

  String? profileImage;
  final fullName = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final about = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final pincode = TextEditingController();
  final skill = TextEditingController();
  final googleDrive = TextEditingController();
  final linkedIn = TextEditingController();
  final gitHub = TextEditingController();
  final gender = TextEditingController();
  final mobile = TextEditingController();

  void setCountryValue(value) {
    countryValue = value;
    notifyListeners();
  }

  void setStateValue(value) {
    stateValue = value;
    notifyListeners();
  }

  void setCityValue(value) {
    cityValue = value;
    notifyListeners();
  }

  Future<void> setVendorProfile(VendorAddressModel vendorAddressModel,
      VendorSkillsModel vendorSkillsModel, BuildContext context) async {
    final addressResult = await CompleteSignUPService().updateVendorAddress(vendorAddressModel);
    final skillResult = await CompleteSignUPService().updateVendorSkill(vendorSkillsModel);
    if(addressResult!=null && skillResult !=null){
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const VendorBottomNavBar(),), (route) => false);
    }
  }
}
