class ApiConstants {
  static const String socketBaseUrl = "http://10.0.60.206:9091";
  static const String baseUrl = "http://10.0.60.206:9090/api/v1";
  static const String imageBaseUrl = "http://10.0.60.206:9090";
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
  static String getSingleUserEndPoint(String userID) => "/users/profile/$userID";
  static const String getMatchListEndPoint = "/users/all/lick-list";
  static const String likeUserEndPoint = "/users/lick";
  static const String interestEndPoint = "/interests/all";
  static const String idealMatchesEndPoint = "/matches/all";
  static const String userMatchingEndPoint = "/users/matching";
  static const String setLocationEndPoint = "/info/location";
  static const String termsConditionEndPoint = "/info/terms-services";
  static const String privacyPolicyEndPoint = "/info/privacy-policy";
  static const String aboutUsEndPoint = "/info/about-us";

  static  String getAllSingleMessageEndPoint (String id) =>  "/conversation/get-messages?conversationId=$id";
  static const String getAllMessageUserEndPoint = "/conversation/conversation-list";
 // static  String getAllMessageUserEndPoint (String page, String limit ) => "/conversation/conversation-list";
  //static  String getMessageEndPoint (String page, String limit, String id ) => "/message/$id?page=$page&limit=$limit";
  static  String conversationMediaEndPoint (String page, String limit, String id ) => "/conversation/media/$id?page=$page&limit=$limit";
  static  String messageEndPoint =  "/message";
  static  String messageLocationEndPoint =  "/message/location";
  static  String createMatchEndPoint(String userID) =>  "/match?userID=$userID";
  static  String blockConversationEndPoint(String id) =>  "/conversation/block/$id";
  static  String getUserByIdEndPoint (String id) =>  "/users/$id";
  static  String deleteConversationEndPoint (String id) =>  "/conversation/$id";

  static  String reportEndPoint =  "/report";

}
