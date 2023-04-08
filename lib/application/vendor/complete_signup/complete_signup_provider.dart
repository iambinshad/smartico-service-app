
import 'package:flutter/material.dart';

class CompleteSignUpProvider with ChangeNotifier{
  
dynamic countryValue ;
dynamic stateValue ;
dynamic cityValue ;

String? profileImage ;
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
  

void setCountryValue (value){
   countryValue= value;
  notifyListeners();
  
}
void setStateValue(value){
  stateValue =value;
  notifyListeners();
  
}
void setCityValue(value){
  cityValue = value;
  notifyListeners();
}
}