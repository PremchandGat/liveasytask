import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liveasy/UI/pages/auth/verify_otp.dart';
import 'package:liveasy/UI/pages/home.dart';
import 'package:provider/provider.dart';

class PhoneNumberAuth extends ChangeNotifier {
  TextEditingController otp = TextEditingController();
  String verificationID = "";
  PhoneNumber number =
      PhoneNumber(isoCode: 'IND', dialCode: '91', phoneNumber: null);
  bool enableButton = false;
  bool isLoadingButton = false;
  updatePhoneNumber(PhoneNumber phoneNumber) {
    number = phoneNumber;
  }

  onOtpCallBack(String otpCode, bool isAutofill, context) {
    if (otpCode.length == 6 && isAutofill) {
      enableButton = false;
      isLoadingButton = true;
      notifyListeners();
      verifyOTPAndLogin(context);
    } else if (otpCode.length == 6 && !isAutofill) {
      enableButton = true;
      isLoadingButton = false;
      notifyListeners();
    } else {
      enableButton = false;
      notifyListeners();
    }
  }

  verifyOTPAndLogin(context) async {
    isLoadingButton = !isLoadingButton;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp.text);
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false));
  }

  verifyPhoneNumber(context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number.phoneNumber.toString(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then(
            (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false));
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        verificationID = verificationId;
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyOtp(),
          ),
        );
        // Sign the user in (or link) with the credential
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
