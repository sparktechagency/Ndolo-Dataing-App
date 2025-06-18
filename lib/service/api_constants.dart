class ApiConstants {
  //==================> Live API <=================
  static const String socketBaseUrl = "https://ws.ndolomeet.com";
  static const String baseUrl = "https://api.ndolomeet.com/api/v1/";
  static const String imageBaseUrl = "https://api.ndolomeet.com";

   //==================> Local API <=================
  // static const String socketBaseUrl = "http://10.0.60.206:9091";
  // static const String baseUrl = "http://10.0.60.206:9090/api/v1";
  // static const String imageBaseUrl = "http://10.0.60.206:9090";

  static const String signUpEndPoint = "/auth/register";
  static const String otpVerifyEndPoint = "/auth/verify-email";
  static const String logInEndPoint = "/auth/login";
  static const String forgotPassEndPoint = "/auth/forgot-password";
  static const String resetPassEndPoint = "/auth/reset-password";
  static const String changePassEndPoint = "/auth/change-password";
  static const String updateLocationEndPoint = "/info/location";
  static const String getProfileEndPoint = "/users/self/in";
  static const String updateProfileEndPoint = "/users/self/update";
  static const String updateGalleryEndPoint = "/users/self/gallery";
  static const String getHomeAllUserEndPoint = "/users/all/profiles";
  static const String getHomeFilterUserEndPoint = "users/all/profiles?fullName=Testing&maxDistance=4&minAge=5&maxAge=35&idealMatch=67a9de1f1d839809c164c30e&country=&city=&state=";
  static String getSingleUserEndPoint(String userID) => "/users/profile/$userID";
  static const String getMatchListEndPoint = "/users/all/lick-list";
  static const String likeUserEndPoint = "/users/lick";
  static const String interestEndPoint = "/interests/all";
  static const String idealMatchesEndPoint = "/matches/all";
  static const String userMatchingEndPoint = "/users/matching";
  static const String setLocationEndPoint = "/info/location";
  static const String setDistanceEndPoint = "/users/self/set-distance";
  static const String termsConditionEndPoint = "/info/terms-services";
  static const String privacyPolicyEndPoint = "/info/privacy-policy";
  static const String aboutUsEndPoint = "/info/about-us";
  static  String getAllSingleMessageEndPoint (String conversationId) =>  "/conversation/get-messages?conversationId=$conversationId";
  static const String getAllConversationEndPoint = "/conversation/conversation-list";
  static const String sentMessageEndPoint = "/conversation/send-message";
  static  String createConversationEndPoint(String receiverId) =>  "/conversation/create";
  static  String sendMessageEndPoint(String conversationId) =>  "/conversation/send-message";
  static  String messageEndPoint =  "/message";
  static  String messageLocationEndPoint =  "/message/location";
  static  String blockConversationEndPoint =  "/conversation/block";
  static  String getUserByIdEndPoint (String id) =>  "/users/$id";
  static  String deleteConversationEndPoint (String id) =>  "/conversation/$id";
  static  String reportEndPoint =  "/report";
  static  String notificationEndPoint =  "/info/notifications";
  static  String deleteAccount =  "/auth/delete-me";

}
