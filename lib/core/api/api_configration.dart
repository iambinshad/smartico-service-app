class ApiConfigration{
  static const kIpAddress = '16.171.20.96';
  static const kBaseUrl = "http://$kIpAddress:3500";

  //----User Endpoints---
  static const login = '/login';
  static const otp = '/OTP';
  static const verifyOtp = '/verifyOTP';
  static const fetchAllGigs = '/allGigs';
  static const getSingleGigDetails = '/singleGig/';  // gig id needed after this endpoint
  static const bookGig = '/reserveNow';
  static const bookedGigs = '/reservedGigs';
  static const getAllVendors = '/getAllVendors';
  static const cancelBooking = '/cancelOrder';
  static const userProfile = '/userProfile';
  static const addReveiw = '/addReview';
  static const vendorAllGigs = "/viewVendorGigs/";
  static const chat = "/chat";
  static const getReviews = '/gigRating/';// gig id needed after this endpoint
  static const updateUserDetails = '/updateUserProfile';
  static const getUserConnections = '/getUserConnections/'; //you need to add user id after this
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
    static const allBookings = '/fetchAllOrders';
    static const allOrders = '/bookedGigs';
    static const completeService  = '/completeUserOrder';
    static const completedOrderByData = '/completed-orders-by-date';
    static const cancelUserBooking = '/cancelUserOrder';
    static const setAddress = '/addAddress/';//vendor id needed after this endpoint
    static const setSkill = '/addSkill/';//vendor id needed after this endpoint
    static const vendorProfile = '/vendorProfile';
    static const updateVendorProfile = '/updateVendorProfile';
    static const getVendorConnections = '/getConnections/'; //you need to add user id after this

  //---Admin Endpoints---

  //after kBaseUrl 
  static const admin = '/admin';//add this /admin before adding endopoints listed down
  static const adminSignUp = '/adminSignup';
  static const adminLogin = '/login';

  static const addCategory = '/addCategory';
  static const fetchAllVendors = '/vendorManagement';
  static const approveVendor = '/approveVendor';
  static const blockVendor = '/blockVendor';
 
}