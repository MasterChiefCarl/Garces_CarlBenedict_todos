import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function()? onDelete;
  final Function()? onToggle;
  final Function()? onEdit;
  final EdgeInsets? margin;
  final ScrollController _sc = ScrollController();

  TodoCard(
      {required this.todo,
      this.onToggle,
      this.onEdit,
      this.onDelete,
      this.margin,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onToggle,
        onLongPress: onEdit,
        child: AspectRatio(
          aspectRatio: 11 / 3,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
            decoration: BoxDecoration(
                color:
                    todo.done ? const Color.fromARGB(255, 255, 196, 0) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todo.parsedDate,
                      style: TextStyle(
                          decoration:
                              todo.done ? TextDecoration.lineThrough : null,
                          fontWeight: todo.done ? null : FontWeight.bold),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.delete, color: Colors.red),
                      iconSize: 20,
                      onPressed: onDelete,
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Scrollbar(
                      controller: _sc,
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        controller: _sc,
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 4),
                        child: Text(
                          todo.details,
                          style: TextStyle(
                              decoration: todo.done
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
