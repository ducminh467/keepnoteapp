import 'package:flutter/material.dart';
import 'package:flutterfirebase/database_helper.dart';
import 'package:flutterfirebase/models/todo.dart';
import 'package:flutter/widgets.dart';

import '../models/task.dart';
import '../widgets.dart';

int valueOfIDTask = 0; //need to put value of an current max id value of task
int valueOfIDTodo = 0; //need to put value of an current max id value of todo in certain task

class Taskpage extends StatefulWidget {
  Task? task;

  Taskpage({required this.task});

  @override
  State<Taskpage> createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      //Set visibility to true

      _contentVisible = true;
      _taskTitle = widget.task!.title;
      _taskDescription = widget.task!.description;
      _taskId = widget.task!.id;
    }

    print("ID: ${widget.task?.id}");

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 12.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Image(
                            width: 24.0,
                            image:
                                AssetImage('lib/assets/images/back_arrow_icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: _titleFocus,
                          onSubmitted: (value) async {
                            //check if the field is not empty
                            if (value != "") {
                              //check if the task is null
                              if (widget.task == null) {
                                DatabaseHelper _dbHelper = DatabaseHelper();
                                Task _newTask = Task(
                                    id: valueOfIDTask,
                                    title: value,
                                    description: "Undefined");

                                print(_newTask);

                                valueOfIDTask++;
                                _taskId = await _dbHelper.insertTask(_newTask);

                                setState(() {
                                  _contentVisible = true;
                                  _taskTitle = value;
                                });

                                print("id task mới: $_taskId");
                              } else {

                                await _dbHelper.updateTaskTitle(_taskId, value);
                                print("Cập nhật task");

                              }

                              _descriptionFocus.requestFocus();
                            }
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: const InputDecoration(
                            hintText: "Nhập tiêu đề",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD95B07)),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      bottom: 12.0,
                    ),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: TextField(
                    focusNode: _descriptionFocus,
                    onSubmitted: (value) async {
                      if(value != ""){
                        if(_taskId != 0){
                          await _dbHelper.updateTaskDescription(_taskId, value);
                          _taskDescription = value;
                        }
                      }
                      _todoFocus.requestFocus();
                    },
                    controller: TextEditingController()..text = _taskDescription,
                    decoration: const InputDecoration(
                        hintText: "Nhập mô tả...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        )),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodo(_taskId),
                    builder: (context, AsyncSnapshot snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {

                                print("Đã xong?: ${snapshot.data[index].isDone}");

                                if(snapshot.data[index].isDone == 0){
                                  await _dbHelper.updateTodoDone(snapshot.data[index].id, 1);
                                }
                                else{
                                 await _dbHelper.updateTodoDone(snapshot.data[index].id, 0);
                                }
                                setState(() {});
                              },
                              child: TodoWidget(
                                text: snapshot.data[index].title,
                                isDone: snapshot.data[index].isDone == 0
                                    ? false
                                    : true,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(
                            right: 12.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: const Color(0xFF86829D))),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Image(
                              image: AssetImage(
                                'lib/assets/images/check_icon.png',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _todoFocus,
                            controller: TextEditingController()..text = "",
                            onSubmitted: (value) async {

                              if (value != "") {

                                if (widget.task!=null) {
                                  Todo _newTodo = Todo(
                                    id: valueOfIDTodo,
                                    title: value,
                                    isDone: 0,
                                    taskId: _taskId,
                                  );

                                  print("Tạo công việc mới: $_newTodo");

                                  valueOfIDTodo++;
                                  await _dbHelper.insertTodo(_newTodo);

                                  setState(() {});
                                  _todoFocus.requestFocus();
                                }
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Nhập công việc cần làm...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _contentVisible,
              child: Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async{
                    if(widget.task!=null){
                      await _dbHelper.deleteTask(_taskId);
                      Navigator.pop(context);
                    }
                  },

                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: const Color(0xFFD90757),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Image(
                          image: AssetImage("lib/assets/images/delete_icon.png"),
                        ),
                      )),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
