import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/getwidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todos = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    final jsonData = jsonDecode(response.body) as List;
    setState(() {
      todos = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {

          },
          onDoubleTap: () {
            setState(() {
              todos.removeAt(index);
            });
          },
          child: Card(
            child: GFListTile(
              title: Text(todos[index]['title']),
              avatar: Icon(todos[index]['completed'] ? Icons.check : Icons.close),
              subTitle: Text('ID: ${todos[index]['id']}'),
            ),
          ),
        );
      },
    );
  }
}
