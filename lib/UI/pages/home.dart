import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liveasy/main.dart';

enum SelectRole { shipper, transhporter }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SelectRole role = SelectRole.shipper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyApp()),
                                  (route) => false));
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          size: 32,
                        )),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Please select your profile",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black // red as border color
                            ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio<SelectRole>(
                        value: SelectRole.shipper,
                        groupValue: role,
                        onChanged: (SelectRole? value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                      SvgPicture.asset("assets/shipper.svg",
                          semanticsLabel: 'Acme Logo'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Shipper",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                              "Lorem ipsum dolor sit amet,\nconsectetur adipiscing")
                        ],
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black // red as border color
                            ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio<SelectRole>(
                        value: SelectRole.transhporter,
                        groupValue: role,
                        onChanged: (SelectRole? value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                      SvgPicture.asset("assets/transporter.svg",
                          semanticsLabel: 'Acme Logo'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Transporter",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                              "Lorem ipsum dolor sit amet,\nconsectetur adipiscing")
                        ],
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                    color: Colors.indigo[900],
                    borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                    child: const Text("CONTINUE"),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
