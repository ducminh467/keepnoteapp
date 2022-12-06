import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutterfirebase/database_helper.dart';
import 'package:flutterfirebase/screens/taskpage.dart';
import 'package:flutterfirebase/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //everything starts from the left
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 24.0,
                      bottom: 32.0,
                    ),
                    child: Image(
                      width: 60,
                      height: 60,
                      image: AssetImage('lib/assets/images/logo.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Taskpage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {}); //refresh all inserted tasks on home page
                    });
                  },
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFFFF7414), Color(0xFFFF491E)],
                              begin: Alignment(0.0, 1.0),
                              end: Alignment(0.0, -1.0)),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image(
                          image: AssetImage("lib/assets/images/add_icon.png"),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
