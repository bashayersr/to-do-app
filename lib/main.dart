import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink,
        accentColor: Colors.blue),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> todoList = [];
  String taskInput = "";

  // createTodoList(){
  //   DocumentReference documentReference = FirebaseFirestore.instance.collection(
  //       "MyTodolist").doc(taskInput);
  //   Map<String,String>todolist = {
  //     "todoTitle" :taskInput
  //   };
  //   documentReference.set(todolist).whenComplete(() => print("$taskInput created "));
  // }

  // deleteTodoList(){
  //
  // }


  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add Todo List"),
                  content: TextField(
                    onChanged: (String value) {
                      taskInput = value;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        setState(() {
                          todoList.add(taskInput);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"),
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(

        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(

                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8)),
                child: ListTile(
                    title: Text(todoList[index]),
                    onLongPress:(){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              title: Text("Enter Edit Todo List"),
                              content: TextField(


                                onChanged: (String value) {
                                  taskInput = value;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.blue),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      todoList[index]=taskInput;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Edit"),
                                )
                              ],
                            );
                          });
                    },
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      Checkbox(
                        activeColor: Colors.black,
                        value: isChecked,
                        onChanged: (bool){

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            todoList.removeAt(index);
                          });
                        },
                        color: Theme
                            .of(context)
                            .errorColor,
                      ),
                    ])
                ),
            ),
          );
        },
            ),
          );
  }
}
