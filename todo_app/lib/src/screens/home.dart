import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [
    Todo(id: 0, details: 'Walk the Goldfish'),
    Todo(id: 1, details: 'Walk the Dog'),
    Todo(id: 2, details: 'Walk the cat'),
  ];

  final ScrollController _sc = ScrollController();
  final TextEditingController _tc = TextEditingController();
  final FocusNode _fn = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Todo App"), backgroundColor: Colors.black),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 255, 196, 0),
                    child: Scrollbar(
                      controller: _sc,
                      child: SingleChildScrollView(
                        controller: _sc,
                        child: Column(
                          children: [
                            for (Todo todo in todos)
                              ListTile(
                                leading: Text(todo.id.toString()),
                                title: Text(todo.created.toString()),
                                subtitle: Text(todo.details),
                                trailing: SizedBox(
                                  child: Wrap(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          String changes = await showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder:
                                                  (BuildContext dialogContext) {
                                                return EditToDo(
                                                  text: todo.details,
                                                );
                                              });
                                          editTodo(changes, todo.id);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          removeTodo(todo.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 0, 63, 92),
                  child: TextFormField(
                    controller: _tc,
                    focusNode: _fn,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        prefix: IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.white),
                          onPressed: () {
                            _fn.unfocus();
                          },
                        ),
                        suffix: IconButton(
                          icon: const Icon(Icons.chevron_right_rounded,
                              color: Colors.white),
                          onPressed: () {
                            addTodo(_tc.text);
                            _tc.text = '';
                            _fn.unfocus();
                          },
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTodo(String details) {
    int index = 0;
    if (todos.isEmpty) {
      index = 0;
    } else {
      index = todos.last.id + 1;
    }

    if (mounted) {
      setState(() {
        todos.add(Todo(details: details, id: index));
      });
    }
  }

  removeTodo(int id) {
    if (todos.isNotEmpty) {
      for (int i = 0; i < todos.length; i++) {
        if (id == todos[i].id) {
          todos.removeAt(i);
          setState(() {});
        }
      }
    }
  }

  editTodo(String details, int id) {
    if (todos.isNotEmpty) {
      Todo temp = Todo(id: id, details: details);
      for (int i = 0; i < todos.length; i++) {
        if (id == todos[i].id) {
          todos[i] = temp;
          setState(() {});
        }
      }
    }
  }
}

class Todo {
  String details;
  late DateTime created;
  int id;
  bool done = false;

  Todo({this.details = '', DateTime? created, this.id = 0}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }

  String get parsedDate {
    return Moment.fromDateTime(created).format('hh:mm a MMMM dd, yyyy ');
  }

  updateDetails(String update) {
    details = update;
    created = DateTime.now();
  }

  toggleDone() {
    done = !done;
  }
}

class EditToDo extends StatefulWidget {
  const EditToDo({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  State<EditToDo> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  String status = '';
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: widget.text);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 5.0, 0),
                child: const Text("Edit Note",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: Column(
                children: [
                  TextFormField(
                    
                    // initialValue: "Change Value",
                    textAlign: TextAlign.left,
                    textCapitalization: TextCapitalization.words,
                    cursorColor: Colors.black,
                    cursorHeight: 30,
                    controller: controller,
                  ),
                  if (status.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(status,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 12, 75, 126)),
                ),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    Navigator.of(context).pop(controller.text);
                  } else {
                    if (mounted) {
                      setState(() {
                        status =
                            "Please Input Your Name. Click Proceed when done";
                      });
                    }
                  }
                },
                child: const Text(
                  "Change Todo Item",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
