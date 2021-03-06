import '/screens/locked_door_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //a Scaffold serves as a screen skeleton, allowing you to add drawers, appbars and more
    return Scaffold(
      //a SafeArea widget automatically compensates for device statusbars, controls, etc on both ios/android
      backgroundColor: Colors.blueGrey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: const [
                      Text(
                        "Welcome to the app!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        " I am the narrator! Here in this app I will walk you through this app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amberAccent)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LockedDoorScreen(),
                      ),
                    );
                  },
                  child: const Text("What is it?")),
              // const Text(
              //   "This was meant to be a joke. Please dont take it seriously",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.white,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
