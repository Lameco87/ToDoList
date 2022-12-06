import "package:flutter/material.dart";
import 'package:to_do_list/util/dialog_box.dart';

import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController();

  //list of todo tasks
  List toDoList = [
    ["Make a tutorial", false],
    ["Do exercise", false],
    ["Make her happy", true],
  ];

  //checkboa was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //Save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  //create new task when press flowactionbutton
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
      });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],

      //AppBar
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Things I need to do ..."),
      ),

      //Body
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        child: Icon(Icons.add),
      ),
    );
  }
}
