import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SafeDial extends StatelessWidget {
  final int startval;
  final Function()? onInc;
  final Function()? onDec;
  const SafeDial({Key? key, required this.startval, this.onInc, this.onDec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      constraints: const BoxConstraints(minHeight: 40),
      child: Column(
        children: [
          IconButton(
              onPressed: onInc,
              icon: const Icon(CupertinoIcons.chevron_up, color: Colors.white)),
          Expanded(
              child: Text("$startval",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white))),
          IconButton(
              onPressed: onDec,
              icon:
                  const Icon(CupertinoIcons.chevron_down, color: Colors.white)),
        ],
      ),
    );
  }
}
