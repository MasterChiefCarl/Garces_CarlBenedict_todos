import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [
    Todo(id: 0, details: 'Walk the Goldfish'),
    Todo(id: 1, details: 'Walk the Dog'),
    Todo(id: 2, details: 'Walk the cat'),
    Todo(id: 3, details: 'Walk the Goldfish'),
    Todo(id: 4, details: 'Walk the Dog'),
    Todo(id: 5, details: 'Walk the cat'),
    Todo(id: 0, details: 'Walk the Goldfish'),
    Todo(id: 6, details: 'Walk the Dog'),
    Todo(id: 7, details: 'Walk the cat'),
  ];

  final ScrollController _sc = new ScrollController();

  final TextEditingController _tc = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Todo App")),
        body: SafeArea(
          child: Column(children: [
            Flexible(
                flex: 3,
                child: Container(
                    color: Colors.amber,
                    child: Column(children: [
                      for (Todo todo in todos)
                        ListTile(
                            leading: Text(todo.id.toString()),
                            title: Text(todo.created.toString()),
                            subtitle: Text(todo.details),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ))
                    ]))),
            Flexible(
                flex: 1,
                child: Container(
                    color: Colors.grey,
                    child: TextFormField(
                        controller: _tc,
                        maxLines: 5,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ))))
          ]),
        ));
  }

  addTodo(String details) {
    int index = 0;
    if (todos.isEmpty) todos.add(Todo(details: details, id: index));
  }

  removeTodo(int id){
    if (todos.isNotEmpty)
    {for (int i= 0; i <todos.length; i++){
      if (id == todos[1].id){
        todos.removeAt(i);
      }
    }}
  }
}

class Todo {
  String details;
  late DateTime created;
  int id;

  Todo({this.details = '', DateTime? created, this.id = 0}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }
}
