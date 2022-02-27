// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> values = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ELEC 2B REVIEW"),
        ),
        body: Column(
          children: [
            for (int value in values)
              IncrementalNumberHolder(
                  startval: value,
                  onUpdate: (int v) {
                    setState(() {
                      value = v;
                    });
                  }),
            Text("This Hold the total of all the values "),
            NumberHolder(content: sumOfAllValues(values)),
          ],
        ));
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
        child: Text("$content", textAlign: TextAlign.center));
  }
}

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
