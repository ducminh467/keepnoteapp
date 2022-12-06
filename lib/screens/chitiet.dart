import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _products = FirebaseFirestore.instance;
CollectionReference _add = _products.collection('products');


class Chitiet extends StatefulWidget {
  Chitiet({Key? key, required this.id, required this.name, required this.note, required this.date})
      : super(key: key);
  final String id, name, note, date;
  // DateTime dateTime = DateTime.now();




  @override
  State<Chitiet> createState() => _ChitietState();
}

class _ChitietState extends State<Chitiet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
   // TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    noteController.text = widget.note;
    // dateController = widget.dateTime.toString() as TextEditingController;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          'Chi tiết',
          style: TextStyle(fontFamily: 'NotoSerif', fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tên công việc: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              TextField(
                controller: nameController,
              ),
              const Text(
                'Ghi chú: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
              TextField(
                controller: noteController,
              ),
              Text(
                'Ngày thêm: ${widget.date}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text("Cập nhật"),
                    onPressed: () {
                      _add.doc(widget.id).update({
                        "name": nameController.text,
                        "note": noteController.text,
                        "date": "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}, ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    // "date": dateController.text,
    });
    Navigator.pop(context);
    },
    ),
    ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
