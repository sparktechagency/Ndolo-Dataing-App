import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../controllers/messages/message_controller.dart';
import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';

class CallInvitation extends StatelessWidget {
  final Widget child;
  final String email;
  final String name;
  CallInvitation(
      {super.key,
        required this.child,
        required this.email,
        required this.name});

  MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 1673796822,
      appSign: '7be1a56632a155960495505610fc86cbfb5e0ff93adb408af4e37002164da436',
      userID: email,
      userName: name,
      plugins: [ZegoUIKitSignalingPlugin()],
      config: ZegoCallInvitationConfig(
          endCallWhenInitiatorLeave: true,
          missedCall: ZegoCallInvitationMissedCallConfig(enabled: false)),
      invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
        onIncomingCallTimeout: (String callID, ZegoCallUser caller) async {
          print("=============missed call 3");
          var receiverID = await PrefsHelper.getString(AppConstants.receiverId);
          var conversationID =
          await PrefsHelper.getString(AppConstants.conversationID);
          messageController.sentMessage(
              "Miss Call-Code : ******#####%%%%^^^^^&&&&*****",
              receiverID);
          //  Add your custom logic here.
        },
        onIncomingMissedCallClicked: (
            String callID,
            ZegoCallUser caller,
            ZegoCallInvitationType callType,
            List<ZegoCallUser> callees,
            String customData,
            // The default action is to dial back the missed call
            Future<void> Function() defaultAction,
            ) async {
          // Add your custom logic here.
          print("=============missed call 2");
          await defaultAction.call();
        },
        onIncomingMissedCallDialBackFailed: () {
          print("=============missed call");
          // Add your custom logic here.
        },
        onIncomingCallCanceled: (callID, caller, customData) {
          print("===================> On Call Canceled");
        },
        onOutgoingCallRejectedCauseBusy: (callID, callee, customData) async {
          var receiverID = await PrefsHelper.getString(AppConstants.receiverId);
          var conversationID =
          await PrefsHelper.getString(AppConstants.conversationID);
          messageController.sentMessage(
              "Miss Call-Code : ******#####%%%%^^^^^&&&&*****",
              receiverID);

          print("============================> On Call Canceled busy");
        },
        onOutgoingCallDeclined: (callID, callee, customData) {
          print("=====================> On Call Canceled busy Declined");
        },
      ),
    );
    return child;
  }
}

// on user logout
void onUserLogout() {
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
