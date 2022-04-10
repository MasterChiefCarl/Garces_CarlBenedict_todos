import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/auth_controller.dart';
import 'package:todo_app/src/controllers/todo_controller.dart';
import 'package:todo_app/src/models/todo_model.dart';
import 'package:todo_app/src/widgets/dismissible_widget.dart';
import 'package:todo_app/src/widgets/utilities_widget.dart';

import '../../widgets/inputs_widget.dart';
import '../../widgets/todo_card_widget.dart';

class TodoScreen extends StatefulWidget {
  final AuthController auth;
  const TodoScreen(this.auth, {Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoController _todoController;
  final ScrollController _sc = ScrollController();
  AuthController get _auth => widget.auth;
  @override
  void initState() {
    _todoController = TodoController(_auth.currentUser!.username);
    super.initState();
  }

  newTodoListener() {
    print('hey i was just bored so i do some stuff hahahah');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _auth.logout();
            },
            icon: const Icon(Icons.logout)),
        title: const Text("Todo App"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () {
                addTodo(context);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          addTodo(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: AnimatedBuilder(
          animation: _todoController,
          builder: (context, Widget? w) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 10),
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      controller: _sc,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        controller: _sc,
                        child: _todoController.data.isEmpty
                            ? Container(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 125, 25, 125),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'No To Do Tasks Added Yet. Press the + key to create one',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 25),
                                    ),
                                    Image(
                                      image:
                                          AssetImage('assets/images/sleep.png'),
                                      fit: BoxFit.fitWidth,
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  for (Todo todo in _todoController.data)
                                    DismissibleWidget(
                                      // margin: const EdgeInsets.symmetric(vertical: 8),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 5),
                                      item: todo,
                                      child: TodoCard(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        todo: todo,
                                        onToggle: () {
                                          if (todo.done) {
                                            Utils.showSnackBar(context,
                                                'Todo "${todo.details}" not yet Completed');
                                          } else {
                                            Utils.showSnackBar(context,
                                                'Todo "${todo.details}"  Completed');
                                          }

                                          _todoController.toggleDone(todo);
                                        },
                                        onDelete: () {
                                          if (todo.done) {
                                            Utils.showSnackBar(context,
                                                'Todo "${todo.details}" has been deleted');
                                            _todoController.removeTodo(todo);
                                          } else {
                                            Utils.showSnackBar(context,
                                                'CANNOT DELETE NOTE! Note "${todo.details}" must be Marked Complete to delete. Tap to Mark Completion');
                                          }
                                        },
                                        onEdit: () {
                                          editTodo(context, todo);
                                        },
                                      ),
                                      confirmDismiss: (direction) async {
                                        {
                                          switch (direction) {
                                            case DismissDirection.endToStart:
                                              if (todo.done) {
                                                Utils.showSnackBar(context,
                                                    'Todo "${todo.details}" has been deleted');
                                                _todoController
                                                    .removeTodo(todo);
                                                return true;
                                              } else {
                                                Utils.showSnackBar(context,
                                                    'CANNOT DELETE NOTE! Note "${todo.details}" must be Marked Complete to delete. Tap to Mark Completion');
                                                return false;
                                              }
                                            case DismissDirection.startToEnd:
                                              editTodo(context, todo);
                                              return false;
                                            default:
                                              return false;
                                          }
                                        }
                                      },
                                    ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  addTodo(BuildContext context) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        builder: (aContext) {
          //addTodo Context builder
          return const Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: InputWidget(),
          );
        });
    if (result != null) {
      _todoController.addTodo(result);
    }
  }

  editTodo(BuildContext context, Todo todo) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        builder: (eContext) {
          //editTodo Context Builder
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: InputWidget(
              current: todo.details,
            ),
          );
        });
    if (result != null) {
      Utils.showSnackBar(context, 'Todo has been updated');
      _todoController.updateTodo(todo, result.details);
    }
  }
}
