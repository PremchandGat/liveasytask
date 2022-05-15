import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liveasy/UI/pages/auth/login.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  String dropdownvalue = 'English';

  // List of items in our dropdown menu
  var items = [
    'English',
    'Hindi',
    'Tamil',
    'Korean',
    'Chinese',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: SvgPicture.asset("assets/image.svg",
                    semanticsLabel: 'Select Language'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Please select your Language",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                ),
              ),
              const Text("You can change the laungauge",
                  style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        112,
                        109,
                        109,
                      ),
                      fontSize: 16)),
              const Text("at any time.",
                  style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        112,
                        109,
                        109,
                      ),
                      fontSize: 16)),
              Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                width: MediaQuery.of(context).size.width * 0.6,
                child: DropdownButtonFormField(
                  decoration:
                      const InputDecoration(enabledBorder: InputBorder.none),
                  style: const TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 87, 85, 85)),
                  iconSize: 32,
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    dropdownvalue = value!;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CupertinoButton(
                    color: Colors.indigo[900],
                    borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                    child: const Text("NEXT"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoginViaPhoneNumber()));
                    }),
              ),
            ],
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
