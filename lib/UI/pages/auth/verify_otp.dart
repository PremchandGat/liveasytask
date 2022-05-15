import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/provider/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final int _otpCodeLength = 6;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(0.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        print("We got message");
        print("////////////////////////////////");
        print(message);
        _otpCode = SmsVerification.getCode(message, intRegex);
        //   textEditingController.text = _otpCode;
        print("Received  OTP$_otpCode");
        Provider.of<PhoneNumberAuth>(context, listen: false)
            .onOtpCallBack(_otpCode, true, context);
      });
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                            )),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Verify Phone",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                    ),
                  ),
                  Text(
                      "Code is sent to ${Provider.of<PhoneNumberAuth>(context).number.phoneNumber}",
                      style: const TextStyle(
                          color: Color.fromARGB(
                            255,
                            112,
                            109,
                            109,
                          ),
                          fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 0),
                    child: TextFieldPin(
                        textController:
                            Provider.of<PhoneNumberAuth>(context).otp,
                        autoFocus: true,
                        codeLength: _otpCodeLength,
                        alignment: MainAxisAlignment.center,
                        defaultBoxSize: MediaQuery.of(context).size.width / 8,
                        margin: MediaQuery.of(context).size.width * 0.01,
                        selectedBoxSize: MediaQuery.of(context).size.width / 8,
                        textStyle: const TextStyle(fontSize: 16),
                        defaultDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(0),
                          border:
                              Border.all(color: Colors.blue.withOpacity(0.6)),
                          color: Colors.blue.withOpacity(0.6),
                        ),
                        selectedDecoration: _pinPutDecoration,
                        onChange: (code) =>
                            Provider.of<PhoneNumberAuth>(context, listen: false)
                                .onOtpCallBack(code, false, context)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the code?",
                          style: TextStyle(
                              color: Color.fromARGB(
                                255,
                                112,
                                109,
                                109,
                              ),
                              fontSize: 16)),
                      TextButton(
                          onPressed: _onClickRetry,
                          child: const Text("Request againt"))
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                        color: Colors.indigo[900],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.0)),
                        child: const Text("VERIFY AND CONTINUE"),
                        onPressed:
                            Provider.of<PhoneNumberAuth>(context).enableButton
                                ? () => Provider.of<PhoneNumberAuth>(context,
                                        listen: false)
                                    .verifyOTPAndLogin(context)
                                : null),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: WaveWidget(
              wavePhase: 50,
              waveFrequency: 2,
              config: CustomConfig(
                colors: [
                  Colors.blue.withOpacity(0.5),
                  Colors.grey.withOpacity(0.5),
                ],
                durations: [
                  15000,
                  20000,
                ],
                heightPercentages: [
                  0.3,
                  0.3,
                ],
              ),
              waveAmplitude: 20,
              size: Size(
                MediaQuery.of(context).size.width,
                100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
