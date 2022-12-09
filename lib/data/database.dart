import "package:hive_flutter/hive_flutter.dart";

class ToDoDataBase {

List toDoList = [];

//reference our box
final _myBox = Hive.box('mybox');

//run this method if this is the first time ever opening this app
void createInitialData(){
  toDoList = [
    ["Make Tutorial", false],
    ["Do Some Code", false],
    ["Make Her Happy 2 times", true],
  ];
}

//load data from database
void loadData() {
  toDoList = _myBox.get("TODOLIST");
}

//update database
void updateDataBase(){
  _myBox.put("TODOLIST", toDoList);
}

}