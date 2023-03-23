class ApiConfigration{
  static const kIpAddress = '10.4.3.119';
  static const kBaseUrl = "http://$kIpAddress:3500";

  //----User Endpoints---
  static const login = '/login';
  static const otp = '/OTP';
  static const verifyOtp = '/verifyOTP';

  //---Vendor Endpoints---

  //after kBaseUrl 
  static const vendor = '/vendor';

  static const vendorLogin = '/login';
  static const vendorOTP = '/vendorOTP';
  static const verifyVendorOTP = '/verifyVendorOTP';
 
}