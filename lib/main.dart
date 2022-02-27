// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_mobiledev1/safe_cracker_widget/safe_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Review App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeCracker(title: 'Lockpick UI'),
    );
  }
}

class SafeCracker extends StatefulWidget {
  const SafeCracker({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SafeCracker> createState() => _SafeCrackerState();
}

class _SafeCrackerState extends State<SafeCracker> {
  List<int> values = [0, 0, 0];
  String combination = "420";
  String feedback = "";
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: const Text("Lockpicker"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  isUnlocked
                      ? CupertinoIcons.lock_open_fill
                      : CupertinoIcons.lock_fill,
                  size: 128,
                  color: isUnlocked ? Colors.green : Colors.redAccent),
              Container(
                margin: EdgeInsets.symmetric(vertical: 32),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < values.length; i++)
                      SafeDial(
                        startval: values[i],
                        onInc: () {
                          setState(() {
                            if (values[i] < 9) {
                              values[i]++;
                            }
                          });
                        },
                        onDec: () {
                          setState(() {
                            if (values[i] > 0) {
                              values[i]--;
                            }
                          });
                        },
                      ),
                  ],
                ),
              ),
              if (feedback.isNotEmpty)
                Text(
                  feedback,
                  style: TextStyle(
                      fontSize: 30,
                      color: isUnlocked ? Colors.green : Colors.red),
                ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 32),
                child: TextButton(
                    onPressed: () {
                      UnlockSafe();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(32),
                        color: isUnlocked ? Colors.green : Colors.red,
                        child: Text("Open the Safe",
                            style: TextStyle(
                                color: isUnlocked
                                    ? Colors.white
                                    : Colors.black)))),
              ),
            ],
          ),
        ));
  }

  // ResetSafe() {
  //   setState(() {
  //     String feedback = "";
  //     bool isUnlocked = false;
  //     List<int> values = [0, 0, 0];
  //   });
  // } was trying a reset function but didnt work in the meantime

  UnlockSafe() {
    if (checkCombo()) {
      setState(
        () {
          isUnlocked = true;
          feedback = "Safe is Unlocked!";
        },
      );
    } else {
      setState(
        () {
          isUnlocked = false;
          feedback = "Safe not Unlocked!";
        },
      );
    }
  }

  bool checkCombo() {
    String theCurrentValue = convertValuestoConvertableString(values);
    bool isUnlocked = (theCurrentValue == combination);
    return isUnlocked;
  }

  String convertValuestoConvertableString(List<int> val) {
    String temp = "";
    for (int v in val) {
      temp += "$v";
    }
    return temp;
  }

  int sumOfAllValues(List<int> list) {
    int temp = 0;
    for (int val in list) {
      temp += val;
    }
    return temp;
  }
}

class NumberHolder extends StatelessWidget {
  final dynamic content;
  const NumberHolder({Key? key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 60),
        width: double.infinity,
        color: Colors.orangeAccent,
        child: Text(
          "$content",
          textAlign: TextAlign.center,
        ));
  }
}



//JUNK CODE / OLD CODE
/*
class IncrementalNumberHolder extends StatefulWidget {
  final Function(int) onUpdate;
  final int startval;
  const IncrementalNumberHolder(
      {Key? key, this.startval = 0, required this.onUpdate})
      : super(key: key);

  @override
  State<IncrementalNumberHolder> createState() =>
      _IncrementalNumberHolderState();
}

class _IncrementalNumberHolderState extends State<IncrementalNumberHolder> {
  @override
  void initState() {
    currentVal = widget.startval;
    super.initState();
  }

  late int currentVal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  currentVal--;
                });
                widget.onUpdate(currentVal);
              },
              icon: const Icon(Icons.chevron_left)),
          Expanded(child: Text("$currentVal", textAlign: TextAlign.center)),
          IconButton(
              onPressed: () {
                setState(() {
                  currentVal++;
                });
                widget.onUpdate(currentVal);
              },
              icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
*/