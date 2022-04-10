import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class InputWidget extends StatefulWidget {
  final String? current;

  const InputWidget({this.current, Key? key}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController _tCon = TextEditingController();

  String? get current => widget.current;

  @override
  void initState() {
    if (current != null) _tCon.text = current as String;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState?.validate();
          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(current != null ? 'Edit Todo' : 'Add new Todo'),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                cursorColor: Colors.orange,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    filled: true, focusColor: Colors.orange),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                controller: _tCon,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: (_formKey.currentState?.validate() ?? false)
                  ? () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop(Todo(details: _tCon.text));
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  primary: (_formKey.currentState?.validate() ?? false)
                      ? Colors.orange
                      : Colors.grey),
              child: Text(current != null ? 'Edit' : 'Add'),
            )
          ],
        ),
      ),
    );
  }
}
