class ApiConfigration{
  static const kIpAddress = '10.4.3.242';
  static const kBaseUrl = "http://$kIpAddress:3500";

  //----User Endpoints---
  static const login = '/login';
  static const otp = '/OTP';
  static const verifyOtp = '/verifyOTP';
  static const fetchAllGigs = '/allGigs';
  static const getSingleGigDetails = '/singleGig/';  // gig id needed after this endpoint

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
  static const deleteGig = '/deleteGig/'; // gig id needed after this endpoint
    static const editGig = '/updateVendorGig'; 



  
  //---Admin Endpoints---

  //after kBaseUrl 
  static const admin = '/admin';//add this /admin before adding endopoints listed down
  static const adminSignUp = '/adminSignup';
  static const adminLogin = '/login';

  static const addCategory = '/addCategory';
 
}