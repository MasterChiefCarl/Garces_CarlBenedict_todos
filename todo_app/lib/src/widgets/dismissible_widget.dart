import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const DismissibleWidget({
    required this.item,
    required this.child,
    required this.confirmDismiss,
    Key? key,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        padding: padding,
        child: Dismissible(
          key: ObjectKey(item),
          background: buildSwipeActionLeft(),
          secondaryBackground: buildSwipeActionRight(),
          child: child,
          confirmDismiss: confirmDismiss,
        ),
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.black,
        child: Icon(Icons.edit, color: Colors.green, size: 32),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.black,
        child: Icon(Icons.delete_forever, color: Colors.red, size: 32),
      );
}


//Credits to Johannes Milke on YT for the template
//https://youtu.be/cswTKnXtSqk
//https://github.com/JohannesMilke/dismissible_actions_example.git
