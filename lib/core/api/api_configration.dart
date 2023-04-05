class ApiConfigration{
  static const kIpAddress = '10.4.3.119';
  static const kBaseUrl = "http://$kIpAddress:3500";

  //----User Endpoints---
  static const login = '/login';
  static const otp = '/OTP';
  static const verifyOtp = '/verifyOTP';

  //---Vendor Endpoints---

  //after kBaseUrl 
  static const vendor = '/vendor'; //add this /vendor before adding endopoints listed down

  static const vendorLogin = '/login';
  static const vendorOTP = '/vendorOTP';
  static const verifyVendorOTP = '/verifyVendorOTP';

  //gig create 
  static const newGIgCreate = '/newGig';
  static const getallCategories = '/categories';
  static const showAllVendorGigs = '/viewGigs';

  
  //---Admin Endpoints---

  //after kBaseUrl 
  static const admin = '/admin';//add this /admin before adding endopoints listed down
  static const adminSignUp = '/adminSignup';
  static const adminLogin = '/login';

  static const addCategory = '/addCategory';
 
}