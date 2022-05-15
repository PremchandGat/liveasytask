import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liveasy/provider/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginViaPhoneNumber extends StatefulWidget {
  const LoginViaPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginViaPhoneNumber> createState() => _LoginViaPhoneNumberState();
}

class _LoginViaPhoneNumberState extends State<LoginViaPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            size: 32,
                          )),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Please enter your mobile number",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                  ),
                ),
                const Text("You'll receive a 6 digit code",
                    style: TextStyle(
                        color: Color.fromARGB(
                          255,
                          112,
                          109,
                          109,
                        ),
                        fontSize: 16)),
                const Text("to verify next.",
                    style: TextStyle(
                        color: Color.fromARGB(
                          255,
                          112,
                          109,
                          109,
                        ),
                        fontSize: 16)),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: InternationalPhoneNumberInput(
                    maxLength: 12,
                    hintText: "Mobile Number",
                    initialValue: Provider.of<PhoneNumberAuth>(context).number,
                    inputBorder: InputBorder.none,
                    onInputChanged:
                        Provider.of<PhoneNumberAuth>(context).updatePhoneNumber,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                      color: Colors.indigo[900],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(0.0)),
                      child: const Text("CONTINUE"),
                      onPressed: () =>
                          Provider.of<PhoneNumberAuth>(context, listen: false)
                              .verifyPhoneNumber(context)),
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
    ));
  }
}
