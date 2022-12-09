import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:to_do_list/util/dialog_box.dart';

import '../data/database.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else {
      // there already exists
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //Save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
    db.updateDataBase();
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

  //Function to delete tasks
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
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
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFuncion: (context) => deleteTask(index),
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
