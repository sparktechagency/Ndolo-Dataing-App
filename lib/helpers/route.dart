import 'package:get/get.dart';
import '../views/screen/AboutUs/about_us_screen.dart';
import '../views/screen/Auth/ChangePass/change_password_screen.dart';
import '../views/screen/Auth/CompleteProfile/complete_profile_screen.dart';
import '../views/screen/Auth/ForgotPass/forgot_password_screen.dart';
import '../views/screen/Auth/OTPScreen/otp_screen.dart';
import '../views/screen/Auth/ResetPass/reset_password_screen.dart';
import '../views/screen/Auth/SignIn/sign_in_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_screen.dart';
import '../views/screen/Auth/UploadPhotos/upload_photos_screen.dart';
import '../views/screen/Filter/filter_screen.dart';
import '../views/screen/Home/home_screen.dart';
import '../views/screen/IdealMatch/ideal_match_screen.dart';
import '../views/screen/Location/location_picker_screen.dart';
import '../views/screen/Location/location_screen.dart';
import '../views/screen/Matches/matches_screen.dart';
import '../views/screen/Message/chat_screen.dart';
import '../views/screen/Message/message_screen.dart';
import '../views/screen/Notifications/notifications_screen.dart';
import '../views/screen/PrivacyPolicy/privacy_policy_screen.dart';
import '../views/screen/Profile/account_information_screen.dart';
import '../views/screen/Profile/edit_account_information.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/ProfileDetails/profile_details_screen.dart';
import '../views/screen/SearchResult/search_result_screen.dart';
import '../views/screen/Settings/settings_screen.dart';
import '../views/screen/Splash/onboarding_screen.dart';
import '../views/screen/Splash/splash_screen.dart';
import '../views/screen/TermsofServices/terms_services_screen.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String onboardingScreen="/onboarding_screen";
  static String signInScreen="/sign-in_screen";
  static String signUpScreen="/sign-up_screen";
  static String forgotPasswordScreen="/forgot_password_screen";
  static String otpScreen="/otp_screen";
  static String resetPasswordScreen="/reset_password_screen";
  static String uploadPhotosScreen="/upload_photos_screen";
  static String changePasswordScreen="/change_password_screen";
  static String completeProfileScreen="/complete_profile_screen";
  static String idealMatchScreen="/ideal_match_screen";
  static String homeScreen="/home_screen";
  static String profileDetailsScreen="/profile_details_screen_screen";
  static String profileScreen="/profile_screen";
  static String accountInformationScreen="/account_information_screen";
  static String editAccountInformation="/edit_account_information";
  static String matchesScreen="/matches_screen";
  static String messageScreen="/message_screen";
  static String chatScreen="/chat_screen";
  static String settingsScreen="/settings_screen";
  static String aboutUsScreen="/about_us_screen";
  static String privacyPolicyScreen="/privacy_policy_screen";
  static String termsServicesScreen="/terms_services_screen";
  static String notificationsScreen="/notifications_screen";
  static String filterScreen="/filter_screen";
  static String searchResultScreen="/search_result_screen";
  static String locationPickerScreen="/location_picker_screen";
  static String locationScreen="/location_screen";

 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
    GetPage(name:onboardingScreen, page: ()=>const OnboardingScreen(),transition:Transition.noTransition),
   GetPage(name:signInScreen, page: ()=> const SignInScreen()),
   GetPage(name:signUpScreen, page: ()=> const SignUpScreen()),
   GetPage(name:forgotPasswordScreen, page: ()=> const ForgotPasswordScreen()),
   GetPage(name:otpScreen, page: ()=> OtpScreen()),
   GetPage(name:resetPasswordScreen, page: ()=> const ResetPasswordScreen()),
   GetPage(name:changePasswordScreen, page: ()=> const ChangePasswordScreen()),
   GetPage(name:uploadPhotosScreen, page: ()=> const UploadPhotosScreen()),
   GetPage(name:completeProfileScreen, page: ()=> const CompleteProfileScreen()),
   GetPage(name:idealMatchScreen, page: ()=> const IdealMatchScreen()),
   GetPage(name:homeScreen, page: ()=>const HomeScreen(),transition:Transition.noTransition),
   GetPage(name:profileDetailsScreen, page: ()=> const ProfileDetailsScreen()),
    GetPage(name:matchesScreen, page: ()=> MatchesScreen(),transition:Transition.noTransition),
    GetPage(name:messageScreen, page: ()=>const MessageScreen(),transition:Transition.noTransition),
    GetPage(name:profileScreen, page: ()=> ProfileScreen(),transition: Transition.noTransition),
    GetPage(name:chatScreen, page: ()=> ChatScreen()),
    GetPage(name:settingsScreen, page: ()=> SettingsScreen()),
    GetPage(name:accountInformationScreen, page: ()=> const AccountInformationScreen()),
    GetPage(name:editAccountInformation, page: ()=> EditAccountInformation()),
    GetPage(name:aboutUsScreen, page: ()=> AboutUsScreen()),
    GetPage(name:privacyPolicyScreen, page: ()=> PrivacyPolicyScreen()),
    GetPage(name:termsServicesScreen, page: ()=> TermsServicesScreen()),
    GetPage(name:notificationsScreen, page: ()=>  NotificationsScreen()),
    GetPage(name:filterScreen, page: ()=>  FilterScreen()),
    GetPage(name:searchResultScreen, page: ()=>  SearchResultScreen()),
    GetPage(name:locationPickerScreen, page: ()=>  LocationPickerScreen()),
    GetPage(name:locationScreen, page: ()=>  LocationScreen()),
  ];
}